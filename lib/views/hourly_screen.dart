// lib/views/hourly_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherly/controllers/hourly_controller.dart';
import 'package:weatherly/models/hourly_model.dart';
import 'dart:ui';

class HourlyScreen extends StatelessWidget {
  const HourlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HourlyController(),
      child: Consumer<HourlyController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF121212),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Card(
                elevation: 0,
                color: const Color(0xFF1B1B1D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildViewSwitcher(context, controller),
                    const Divider(color: Colors.white24, height: 1),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: controller.viewMode == ViewMode.list
                            ? _buildListView(controller.forecastData)
                            : _buildGraphView(controller), // ✅ Updated this line
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ... (ViewSwitcher and ListView code remains the same)

  Widget _buildViewSwitcher(BuildContext context, HourlyController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CupertinoSlidingSegmentedControl<ViewMode>(
        backgroundColor: Colors.grey.shade800,
        thumbColor: const Color(0xFF007AFF),
        groupValue: controller.viewMode,
        onValueChanged: (ViewMode? newValue) {
          if (newValue != null) {
            controller.setViewMode(newValue);
          }
        },
        children: const {
          ViewMode.list: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Text('LIST', style: TextStyle(color: Colors.white)),
          ),
          ViewMode.graph: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Text('GRAPH', style: TextStyle(color: Colors.white)),
          ),
        },
      ),
    );
  }

  Widget _buildListView(List<DailyHourlyForecast> forecastData) {
    return ListView.builder(
        key: const ValueKey('list'),
        padding: EdgeInsets.zero,
        itemCount: forecastData.length,
        itemBuilder: (context, index) {
          final dayForecast = forecastData[index];
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(dayForecast.day,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2)),
                ),
                ...dayForecast.hourlyData
                    .map((hourly) => _buildHourlyRow(hourly))
                    .toList(),
              ]);
        });
  }

  Widget _buildHourlyRow(HourlyForecast hourly) {
    return InkWell(
        onTap: () {},
        child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(children: [
              SizedBox(
                  width: 60,
                  child: Text(hourly.time,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500))),
              const SizedBox(width: 15),
              SizedBox(
                  width: 55,
                  child: Text("${hourly.temp}°",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))),
              const SizedBox(width: 15),
              Icon(hourly.icon, color: Colors.white, size: 30),
              const SizedBox(width: 15),
              Expanded(
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontFamily: 'Poppins'),
                          children: [
                            const TextSpan(text: "RealFeel"),
                            const TextSpan(
                                text: "® ",
                                style: TextStyle(
                                    fontFeatures: [FontFeature.superscripts()])),
                            TextSpan(
                                text: hourly.realFeel,
                                style: const TextStyle(color: Colors.white))
                          ]))),
              const SizedBox(width: 15),
              Text("${hourly.precipitation}%",
                  style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold))
            ])));
  }

  // ✅ NEW: Builds the scrollable list of graph cards
  Widget _buildGraphView(HourlyController controller) {
    final allForecasts =
    controller.forecastData.expand((d) => d.hourlyData).toList();

    return ListView(
      key: const ValueKey('graph-list'),
      padding: const EdgeInsets.all(16.0),
      children: [
        GraphCard(
          graphType: GraphType.temperature,
          allForecasts: allForecasts,
        ),
        const SizedBox(height: 20),
        GraphCard(
          graphType: GraphType.precipitation,
          allForecasts: allForecasts,
        ),
        const SizedBox(height: 20),
        GraphCard(
          graphType: GraphType.wind,
          allForecasts: allForecasts,
        ),
      ],
    );
  }
}

// ✅ NEW: A reusable widget for displaying a single graph
class GraphCard extends StatefulWidget {
  final GraphType graphType;
  final List<HourlyForecast> allForecasts;

  const GraphCard({
    super.key,
    required this.graphType,
    required this.allForecasts,
  });

  @override
  State<GraphCard> createState() => _GraphCardState();
}

class _GraphCardState extends State<GraphCard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedForecast = widget.allForecasts[_selectedIndex];
    String selectedValue = "";
    String title = "";

    switch (widget.graphType) {
      case GraphType.temperature:
        selectedValue = "${selectedForecast.temp}°";
        title = "TEMPERATURE";
        break;
      case GraphType.precipitation:
        selectedValue = "${selectedForecast.precipitation}%";
        title = "PRECIPITATION";
        break;
      case GraphType.wind:
        selectedValue = "${selectedForecast.windSpeed} mph";
        title = "WIND SPEED";
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Graph Title
        Text(title,
            style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2)),
        const SizedBox(height: 16),
        // Selected Value Display
        Center(
          child: Text(selectedValue,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        // Interactive Graph
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            final box = context.findRenderObject() as RenderBox;
            final position = details.localPosition;
            final newIndex =
            (position.dx / box.size.width * widget.allForecasts.length)
                .clamp(0, widget.allForecasts.length - 1)
                .floor();
            if (newIndex != _selectedIndex) {
              setState(() {
                _selectedIndex = newIndex;
              });
            }
          },
          child: CustomPaint(
            size: const Size(double.infinity, 150), // Adjusted height
            painter: _GraphPainter(
              forecasts: widget.allForecasts,
              selectedIndex: _selectedIndex,
              graphType: widget.graphType,
            ),
          ),
        ),
      ],
    );
  }
}

class _GraphPainter extends CustomPainter {
  final List<HourlyForecast> forecasts;
  final int selectedIndex;
  final GraphType graphType;

  _GraphPainter({
    required this.forecasts,
    required this.selectedIndex,
    required this.graphType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (forecasts.isEmpty) return;

    _drawGrid(canvas, size);

    List<double> dataPoints;
    String yAxisLabel;
    List<Color> gradientColors;

    switch (graphType) {
      case GraphType.temperature:
        dataPoints = forecasts.map((f) => f.temp.toDouble()).toList();
        yAxisLabel = "°F";
        gradientColors = [Colors.orange, Colors.cyan];
        break;
      case GraphType.precipitation:
        dataPoints = forecasts.map((f) => f.precipitation.toDouble()).toList();
        yAxisLabel = "%";
        gradientColors = [Colors.blue, Colors.lightBlueAccent];
        break;
      case GraphType.wind:
        dataPoints = forecasts.map((f) => f.windSpeed.toDouble()).toList();
        yAxisLabel = "mph";
        gradientColors = [Colors.green, Colors.yellow];
        break;
    }

    _drawAxisLabels(canvas, size, yAxisLabel);

    final minValue = dataPoints.reduce((a, b) => a < b ? a : b);
    final maxValue = dataPoints.reduce((a, b) => a > b ? a : b);
    final valueRange = (maxValue - minValue).toDouble();

    final points = <Offset>[];
    for (int i = 0; i < dataPoints.length; i++) {
      final x = size.width * (i / (dataPoints.length - 1));
      final y = size.height -
          ((dataPoints[i] - minValue) /
              (valueRange == 0 ? 1 : valueRange) *
              (size.height - 40)) -
          20;
      points.add(Offset(x, y));
    }

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlPoint1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final controlPoint2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, p2.dx, p2.dy);
    }

    final gradientPath = Path.from(path);
    gradientPath.lineTo(size.width, size.height);
    gradientPath.lineTo(0, size.height);
    gradientPath.close();

    final fillGradient = LinearGradient(
      colors: [
        gradientColors.first.withOpacity(0.5),
        gradientColors.first.withOpacity(0.0)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    canvas.drawPath(
        gradientPath,
        Paint()
          ..shader = fillGradient
              .createShader(Rect.fromLTWH(0, 0, size.width, size.height)));

    final linePaint = Paint()
      ..shader = LinearGradient(colors: gradientColors)
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawPath(path, linePaint);

    for (int i = 0; i < forecasts.length; i++) {
      if (i == selectedIndex) {
        canvas.drawLine(Offset(points[i].dx, 0),
            Offset(points[i].dx, size.height), Paint()..color = Colors.white24..strokeWidth = 2);
        canvas.drawCircle(points[i], 8, Paint()..color = Colors.white);
        canvas.drawCircle(points[i], 6, Paint()..color = gradientColors.last);
      }
    }
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;
    for (int i = 1; i <= 10; i++) {
      final x = size.width * (i / 10);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (int i = 1; i <= 5; i++) {
      final y = size.height * (i / 5);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _drawAxisLabels(Canvas canvas, Size size, String yAxisLabel) {
    final textStyle =
    TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12);
    final xAxisLabelPainter = TextPainter(
        text: TextSpan(text: "Time", style: textStyle),
        textDirection: TextDirection.ltr)
      ..layout();
    xAxisLabelPainter.paint(
        canvas, Offset((size.width - xAxisLabelPainter.width) / 2, size.height + 5));
    final startTimePainter = TextPainter(
        text: TextSpan(text: forecasts.first.time, style: textStyle),
        textDirection: TextDirection.ltr)
      ..layout();
    startTimePainter.paint(canvas, Offset(0, size.height + 5));
    final endTimePainter = TextPainter(
        text: TextSpan(text: forecasts.last.time, style: textStyle),
        textDirection: TextDirection.ltr)
      ..layout();
    endTimePainter.paint(
        canvas, Offset(size.width - endTimePainter.width, size.height + 5));

    canvas.save();
    canvas.translate(-10, size.height / 2); // Adjusted for better positioning
    canvas.rotate(-90 * 3.14159 / 180);
    final yAxisLabelPainter = TextPainter(
        text: TextSpan(text: yAxisLabel, style: textStyle),
        textDirection: TextDirection.ltr)
      ..layout();
    yAxisLabelPainter.paint(
        canvas, Offset(-yAxisLabelPainter.width / 2, 0));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GraphPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.forecasts != forecasts ||
        oldDelegate.graphType != graphType;
  }
}