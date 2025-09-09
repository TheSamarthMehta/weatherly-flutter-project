// lib/views/hourly_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weatherly/controllers/hourly_controller.dart';
import 'package:weatherly/models/hourly_model.dart';
import 'package:weatherly/views/widgets/hourly_detail_view.dart';
import 'dart:ui';


class HourlyScreen extends StatelessWidget {
  const HourlyScreen({super.key});

  /// ✅ **REVERTED**: This method now shows a full-screen modal bottom sheet
  /// by removing the height constraint on the Container.
  void _showHourlyDetails(BuildContext context, String day, HourlyForecast forecast) {
    final Map<String, dynamic> dataPayload = {
      "icon": forecast.icon,
      "temp": forecast.temp,
      "precipitation": forecast.precipitation,
      "details": {
        "RealFeel®": forecast.realFeel,
        "Humidity": "81%",
        "Indoor Humidity": "81% (Extremely Humid)",
        "Air Quality": "Poor",
        "Wind": "SW ${forecast.windSpeed} mph",
        "Wind Gusts": "${forecast.windSpeed + 4} mph",
        "Rain Probability": "${forecast.precipitation}%",
        "Cloud Cover": "86%",
        "Dew Point": "74° F",
        "Visibility": "5 mi",
        "Cloud Ceiling": "30000 ft",
      }
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HourlyDetailView(
        time: forecast.time,
        day: day,
        data: dataPayload,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HourlyController(),
      child: Consumer<HourlyController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF121212),
            body: _buildListView(context, controller.processedForecasts),
          );
        },
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<DailyHourlyForecast> forecastData) {
    return ListView.builder(
        key: const ValueKey('list-of-daily-cards'),
        padding: const EdgeInsets.all(16.0),
        itemCount: forecastData.length,
        itemBuilder: (context, index) {
          final dayForecast = forecastData[index];
          return DailyForecastCard(
            dayForecast: dayForecast,
            onHourTap: (forecast) => _showHourlyDetails(context, dayForecast.day, forecast),
          );
        });
  }
}

class DailyForecastCard extends StatefulWidget {
  final DailyHourlyForecast dayForecast;
  final Function(HourlyForecast) onHourTap;

  const DailyForecastCard({super.key, required this.dayForecast, required this.onHourTap});

  @override
  State<DailyForecastCard> createState() => _DailyForecastCardState();
}

class _DailyForecastCardState extends State<DailyForecastCard> with TickerProviderStateMixin {
  ViewMode _viewMode = ViewMode.list;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        elevation: 0,
        color: const Color(0xFF1B1B1D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.dayForecast.day,
                      style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.2)),
                  _buildViewSwitcher(),
                ],
              ),
              const Divider(color: Colors.white24, height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _viewMode == ViewMode.list
                    ? _buildHourlyList()
                    : _buildGraphView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewSwitcher() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade800.withOpacity(0.3),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: CupertinoSlidingSegmentedControl<ViewMode>(
        backgroundColor: Colors.transparent,
        thumbColor: const Color(0xFF007AFF),
        groupValue: _viewMode,
        onValueChanged: (ViewMode? newValue) {
          if (newValue != null) { 
            setState(() { _viewMode = newValue; }); 
          }
        },
        children: const {
          ViewMode.list: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8), 
            child: Text('LIST', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))
          ),
          ViewMode.graph: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8), 
            child: Text('GRAPH', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))
          ),
        },
      ),
    );
  }

  Widget _buildHourlyList() {
    final day = widget.dayForecast;
    List<Widget> timelineWidgets = [];
    bool sunriseAdded = false;
    bool sunsetAdded = false;

    for (var hourly in day.hourlyData) {
      if (!sunriseAdded && hourly.hour >= day.sunriseHour) {
        timelineWidgets.add(_buildEventRow(day.sunriseTime, true));
        sunriseAdded = true;
      }
      if (!sunsetAdded && hourly.hour >= day.sunsetHour) {
        timelineWidgets.add(_buildEventRow(day.sunsetTime, false));
        sunsetAdded = true;
      }
      timelineWidgets.add(_buildHourlyRow(hourly));
    }

    return Column(
      key: ValueKey('list-${widget.dayForecast.day}'),
      children: timelineWidgets,
    );
  }

  Widget _buildEventRow(String time, bool isSunrise) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.amber.withOpacity(0.1),
            Colors.amber.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isSunrise ? PhosphorIcons.sun() : PhosphorIcons.moon(), 
              color: Colors.amber, 
              size: 20
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "${isSunrise ? 'SUNRISE' : 'SUNSET'} $time",
            style: const TextStyle(
              color: Colors.amber, 
              fontWeight: FontWeight.bold, 
              fontSize: 14, 
              letterSpacing: 1.1
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyRow(HourlyForecast hourly) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onHourTap(hourly),
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    hourly.time,
                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(hourly.icon, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${hourly.temp}°",
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white70, fontSize: 15, fontFamily: 'Poppins'),
                      children: [
                        const TextSpan(text: "RealFeel"),
                        const TextSpan(text: "® ", style: TextStyle(fontFeatures: [FontFeature.superscripts()])),
                        TextSpan(text: hourly.realFeel, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.3)),
                    ),
                    child: Text(
                      "${hourly.precipitation}%",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGraphView() {
    return Padding(
      key: ValueKey('graph-${widget.dayForecast.day}'),
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          EnhancedGraphCard(graphType: GraphType.temperature, allForecasts: widget.dayForecast.hourlyData),
          const SizedBox(height: 24),
          EnhancedGraphCard(graphType: GraphType.precipitation, allForecasts: widget.dayForecast.hourlyData),
          const SizedBox(height: 24),
          EnhancedGraphCard(graphType: GraphType.wind, allForecasts: widget.dayForecast.hourlyData),
        ],
      ),
    );
  }
}

class EnhancedGraphCard extends StatefulWidget {
  final GraphType graphType;
  final List<HourlyForecast> allForecasts;

  const EnhancedGraphCard({super.key, required this.graphType, required this.allForecasts});

  @override
  State<EnhancedGraphCard> createState() => _EnhancedGraphCardState();
}

class _EnhancedGraphCardState extends State<EnhancedGraphCard> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.allForecasts.isEmpty) {
      return const SizedBox.shrink();
    }

    final selectedForecast = widget.allForecasts[_selectedIndex];
    String selectedValue = "";
    String title = "";
    IconData icon = PhosphorIcons.thermometer();
    Color primaryColor = Colors.orange;
    Color secondaryColor = Colors.cyan;

    switch (widget.graphType) {
      case GraphType.temperature:
        selectedValue = "${selectedForecast.temp}°";
        title = "TEMPERATURE";
        icon = PhosphorIcons.thermometer();
        primaryColor = Colors.orange;
        secondaryColor = Colors.cyan;
        break;
      case GraphType.precipitation:
        selectedValue = "${selectedForecast.precipitation}%";
        title = "PRECIPITATION";
        icon = PhosphorIcons.cloudRain();
        primaryColor = Colors.blue;
        secondaryColor = Colors.lightBlueAccent;
        break;
      case GraphType.wind:
        selectedValue = "${selectedForecast.windSpeed} mph";
        title = "WIND SPEED";
        icon = PhosphorIcons.wind();
        primaryColor = Colors.green;
        secondaryColor = Colors.yellow;
        break;
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.1),
                    secondaryColor.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(icon, color: primaryColor, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          title,
                          style: TextStyle(
                            color: primaryColor.withOpacity(0.9), 
                            fontWeight: FontWeight.bold, 
                            fontSize: 14,
                            letterSpacing: 1.2
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            selectedValue,
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 32, 
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: primaryColor.withOpacity(0.3),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedForecast.time,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7), 
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            final box = context.findRenderObject() as RenderBox;
                            final position = details.localPosition;
                            final newIndex = (position.dx / box.size.width * widget.allForecasts.length)
                                .clamp(0, widget.allForecasts.length - 1)
                                .floor();
                            if (newIndex != _selectedIndex) {
                              setState(() {
                                _selectedIndex = newIndex;
                              });
                            }
                          },
                          onTapDown: (details) {
                            final box = context.findRenderObject() as RenderBox;
                            final position = details.localPosition;
                            final newIndex = (position.dx / box.size.width * widget.allForecasts.length)
                                .clamp(0, widget.allForecasts.length - 1)
                                .floor();
                            setState(() {
                              _selectedIndex = newIndex;
                            });
                          },
                          child: CustomPaint(
                            size: const Size(double.infinity, 180),
                            painter: EnhancedGraphPainter(
                              forecasts: widget.allForecasts,
                              selectedIndex: _selectedIndex,
                              graphType: widget.graphType,
                              primaryColor: primaryColor,
                              secondaryColor: secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.allForecasts.first.time,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6), 
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.allForecasts.last.time,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6), 
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class EnhancedGraphPainter extends CustomPainter {
  final List<HourlyForecast> forecasts;
  final int selectedIndex;
  final GraphType graphType;
  final Color primaryColor;
  final Color secondaryColor;

  EnhancedGraphPainter({
    required this.forecasts,
    required this.selectedIndex,
    required this.graphType,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (forecasts.isEmpty) return;
    
    _drawBackground(canvas, size);
    _drawGrid(canvas, size);
    _drawDataLine(canvas, size);
    _drawDataPoints(canvas, size);
    _drawSelectedPoint(canvas, size);
  }

  void _drawBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withOpacity(0.1),
          Colors.transparent,
        ],
        center: Alignment.center,
        radius: 0.8,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    // Vertical grid lines
    for (int i = 1; i < forecasts.length; i++) {
      final x = size.width * (i / forecasts.length);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal grid lines
    for (int i = 1; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _drawDataLine(Canvas canvas, Size size) {
    List<double> dataPoints = _getDataPoints();
    final minValue = dataPoints.reduce((a, b) => a < b ? a : b);
    final maxValue = dataPoints.reduce((a, b) => a > b ? a : b);
    final valueRange = (maxValue - minValue).toDouble();

    final points = <Offset>[];
    for (int i = 0; i < dataPoints.length; i++) {
      final x = size.width * (i / (dataPoints.length - 1));
      final y = size.height - ((dataPoints[i] - minValue) / (valueRange == 0 ? 1 : valueRange) * (size.height - 40)) - 20;
      points.add(Offset(x, y));
    }

    // Draw gradient fill
    final fillPath = Path();
    fillPath.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlPoint1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final controlPoint2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      fillPath.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p2.dx, p2.dy);
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillGradient = LinearGradient(
      colors: [
        primaryColor.withOpacity(0.3),
        secondaryColor.withOpacity(0.1),
        Colors.transparent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    
    canvas.drawPath(
      fillPath,
      Paint()..shader = fillGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // Draw main line
    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlPoint1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final controlPoint2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      linePath.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p2.dx, p2.dy);
    }

    final lineGradient = LinearGradient(
      colors: [primaryColor, secondaryColor],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    canvas.drawPath(
      linePath,
      Paint()
        ..shader = lineGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawDataPoints(Canvas canvas, Size size) {
    List<double> dataPoints = _getDataPoints();
    final minValue = dataPoints.reduce((a, b) => a < b ? a : b);
    final maxValue = dataPoints.reduce((a, b) => a > b ? a : b);
    final valueRange = (maxValue - minValue).toDouble();

    for (int i = 0; i < dataPoints.length; i++) {
      final x = size.width * (i / (dataPoints.length - 1));
      final y = size.height - ((dataPoints[i] - minValue) / (valueRange == 0 ? 1 : valueRange) * (size.height - 40)) - 20;
      
      if (i != selectedIndex) {
        // Draw small dots for non-selected points
        canvas.drawCircle(
          Offset(x, y), 
          3, 
          Paint()..color = primaryColor.withOpacity(0.6),
        );
      }
    }
  }

  void _drawSelectedPoint(Canvas canvas, Size size) {
    List<double> dataPoints = _getDataPoints();
    final minValue = dataPoints.reduce((a, b) => a < b ? a : b);
    final maxValue = dataPoints.reduce((a, b) => a > b ? a : b);
    final valueRange = (maxValue - minValue).toDouble();

    final x = size.width * (selectedIndex / (dataPoints.length - 1));
    final y = size.height - ((dataPoints[selectedIndex] - minValue) / (valueRange == 0 ? 1 : valueRange) * (size.height - 40)) - 20;

    // Draw selection line
    canvas.drawLine(
      Offset(x, 0),
      Offset(x, size.height),
      Paint()
        ..color = primaryColor.withOpacity(0.3)
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );

    // Draw outer glow
    canvas.drawCircle(
      Offset(x, y),
      12,
      Paint()
        ..color = primaryColor.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Draw main circle
    canvas.drawCircle(
      Offset(x, y),
      8,
      Paint()..color = Colors.white,
    );

    // Draw inner circle
    canvas.drawCircle(
      Offset(x, y),
      6,
      Paint()..color = primaryColor,
    );
  }

  List<double> _getDataPoints() {
    switch (graphType) {
      case GraphType.temperature:
        return forecasts.map((f) => f.temp.toDouble()).toList();
      case GraphType.precipitation:
        return forecasts.map((f) => f.precipitation.toDouble()).toList();
      case GraphType.wind:
        return forecasts.map((f) => f.windSpeed.toDouble()).toList();
    }
  }

  @override
  bool shouldRepaint(covariant EnhancedGraphPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.forecasts != forecasts ||
        oldDelegate.graphType != graphType ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor;
  }
}