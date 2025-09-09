// lib/views/widgets/air_quality_card.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:math' as math;
import 'package:percent_indicator/percent_indicator.dart';

class AirQualityCard extends StatefulWidget {
  const AirQualityCard({super.key});

  @override
  State<AirQualityCard> createState() => _AirQualityCardState();
}

class _AirQualityCardState extends State<AirQualityCard>
    with TickerProviderStateMixin {
  double _progress = 0.0;
  int _currentIndex = 0;
  int _viewMode = 0; // 0 = Graph, 1 = Gauge, 2 = Wave
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  final List<Map<String, dynamic>> aqiData = [
    {
      "time": "11 AM",
      "value": 31,
      "level": "Fair",
      "color": Colors.green,
      "suggestion": "Air quality is generally acceptable for most individuals."
    },
    {
      "time": "12 PM",
      "value": 26,
      "level": "Fair",
      "color": Colors.green,
      "suggestion": "Sensitive groups may experience minor to moderate symptoms."
    },
    {
      "time": "1 PM",
      "value": 24,
      "level": "Excellent",
      "color": Colors.greenAccent,
      "suggestion": "The air quality is ideal for most individuals."
    },
    {
      "time": "2 PM",
      "value": 23,
      "level": "Excellent",
      "color": Colors.greenAccent,
      "suggestion": "Enjoy your normal outdoor activities."
    },
    {
      "time": "3 PM",
      "value": 20,
      "level": "Excellent",
      "color": Colors.greenAccent,
      "suggestion": "Perfect weather for a walk outside."
    },
    {
      "time": "4 PM",
      "value": 19,
      "level": "Excellent",
      "color": Colors.greenAccent,
      "suggestion": "Enjoy the fresh air!"
    },
    {
      "time": "5 PM",
      "value": 18,
      "level": "Excellent",
      "color": Colors.greenAccent,
      "suggestion": "The air quality is ideal for most individuals."
    },
    {
      "time": "6 PM",
      "value": 21,
      "level": "Excellent",
      "color": Colors.greenAccent,
      "suggestion": "A great time for outdoor exercise."
    },
    {
      "time": "7 PM",
      "value": 23,
      "level": "Fair",
      "color": Colors.green,
      "suggestion": "Air quality is acceptable."
    },
    {
      "time": "8 PM",
      "value": 27,
      "level": "Fair",
      "color": Colors.green,
      "suggestion": "Sensitive groups might feel minor effects."
    },
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _waveAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.linear),
    );
    
    _fadeController.forward();
    _pulseController.repeat(reverse: true);
    _waveController.repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details, double width) {
    setState(() {
      _progress = (_progress + details.delta.dx / width).clamp(0.0, 1.0);
      _currentIndex = (_progress * (aqiData.length - 1)).round();
    });
    HapticFeedback.lightImpact();
  }

  void _switchViewMode() {
    setState(() {
      _viewMode = (_viewMode + 1) % 3;
    });
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.1),
                  Colors.blue.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    _buildMainContent(),
                    const SizedBox(height: 20),
                    _buildViewSwitcher(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.air,
            color: Colors.green,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          "AIR QUALITY INDEX",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.schedule,
                color: Colors.green,
                size: 12,
              ),
              SizedBox(width: 4),
              Text(
                "24H",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    final currentData = aqiData[_currentIndex];
    
    return Column(
      children: [
        _buildCurrentAQI(currentData),
        const SizedBox(height: 20),
        _buildVisualization(currentData),
        const SizedBox(height: 16),
        _buildSuggestion(currentData),
      ],
    );
  }

  Widget _buildCurrentAQI(Map<String, dynamic> data) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current AQI",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "${data['value']}",
                    style: TextStyle(
                      color: data['color'],
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: data['color'].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: data['color'].withOpacity(0.3)),
                    ),
                    child: Text(
                      data['level'],
                      style: TextStyle(
                        color: data['color'],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: data['color'].withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: data['color'].withOpacity(0.3)),
                ),
                child: Icon(
                  _getAQIIcon(data['value']),
                  color: data['color'],
                  size: 32,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  IconData _getAQIIcon(int value) {
    if (value <= 50) return PhosphorIcons.wind(PhosphorIconsStyle.fill);
    if (value <= 100) return PhosphorIcons.cloud(PhosphorIconsStyle.fill);
    if (value <= 150) return PhosphorIcons.warning(PhosphorIconsStyle.fill);
    return PhosphorIcons.warningOctagon(PhosphorIconsStyle.fill);
  }

  Widget _buildVisualization(Map<String, dynamic> data) {
    switch (_viewMode) {
      case 0:
        return _buildGraphView();
      case 1:
        return _buildGaugeView(data);
      case 2:
        return _buildWaveView(data);
      default:
        return _buildGraphView();
    }
  }

  Widget _buildGraphView() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => _onHorizontalDragUpdate(details, 300),
        child: CustomPaint(
          painter: _SmoothAqiGraphPainter(
            aqiData: aqiData,
            selectedIndex: _currentIndex,
            progress: _progress,
          ),
          child: Container(),
        ),
      ),
    );
  }

  Widget _buildGaugeView(Map<String, dynamic> data) {
    final percentage = (data['value'] / 500).clamp(0.0, 1.0);
    
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Center(
        child: CircularPercentIndicator(
          radius: 45,
          lineWidth: 8,
          percent: percentage,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${data['value']}",
                style: TextStyle(
                  color: data['color'],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "AQI",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          progressColor: data['color'],
          backgroundColor: Colors.white.withOpacity(0.1),
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
          animationDuration: 1000,
        ),
      ),
    );
  }

  Widget _buildWaveView(Map<String, dynamic> data) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: AnimatedBuilder(
        animation: _waveAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: _WavePainter(
              color: data['color'],
              animation: _waveAnimation.value,
              intensity: (data['value'] / 500).clamp(0.0, 1.0),
            ),
            child: Container(),
          );
        },
      ),
    );
  }

  Widget _buildSuggestion(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: data['color'].withOpacity(0.1),
        border: Border.all(color: data['color'].withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: data['color'],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              data['suggestion'],
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildViewButton(0, Icons.show_chart, "Graph"),
          _buildViewButton(1, Icons.speed, "Gauge"),
          _buildViewButton(2, Icons.waves, "Wave"),
        ],
      ),
    );
  }

  Widget _buildViewButton(int mode, IconData icon, String label) {
    final isSelected = _viewMode == mode;
    
    return GestureDetector(
      onTap: _switchViewMode,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmoothAqiGraphPainter extends CustomPainter {
  final List<Map<String, dynamic>> aqiData;
  final int selectedIndex;
  final double progress;

  _SmoothAqiGraphPainter({
    required this.aqiData,
    required this.selectedIndex,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw grid lines
    for (int i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw data line
    final dataPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    final pointPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    for (int i = 0; i < aqiData.length; i++) {
      final x = size.width * i / (aqiData.length - 1);
      final value = aqiData[i]['value'] as int;
      final y = size.height * (1 - value / 500);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw points
      final isSelected = i == selectedIndex;
      final pointColor = isSelected ? Colors.green : Colors.green.withOpacity(0.6);
      final pointRadius = isSelected ? 6.0 : 3.0;
      
      canvas.drawCircle(Offset(x, y), pointRadius, Paint()..color = pointColor);
    }

    canvas.drawPath(path, dataPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _WavePainter extends CustomPainter {
  final Color color;
  final double animation;
  final double intensity;

  _WavePainter({
    required this.color,
    required this.animation,
    required this.intensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      final y = size.height * 0.5 + 
                math.sin(x * 0.02 + animation) * 20 * intensity +
                math.sin(x * 0.01 + animation * 0.5) * 10 * intensity;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
