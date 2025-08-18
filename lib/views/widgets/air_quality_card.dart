// lib/views/widgets/air_quality_card.dart
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:percent_indicator/percent_indicator.dart';

class AirQualityCard extends StatefulWidget {
  const AirQualityCard({super.key});

  @override
  State<AirQualityCard> createState() => _AirQualityCardState();
}

class _AirQualityCardState extends State<AirQualityCard>
    with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  int _currentIndex = 0;
  int _viewMode = 0; // 0 = Graph, 1 = Gauge, 2 = Wave

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

  void _onHorizontalDragUpdate(DragUpdateDetails details, double width) {
    setState(() {
      _progress = (_progress + details.delta.dx / width).clamp(0.0, 1.0);
      _currentIndex = (_progress * (aqiData.length - 1)).round();
    });
  }

  Color _getAQIColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 200) return Colors.orange;
    if (aqi <= 300) return Colors.red;
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    final currentAqi = aqiData[_currentIndex];

    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title + Mode Switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "24-HOUR AIR QUALITY INDEX",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _viewMode = (_viewMode + 1) % 3;
                          });
                        },
                        icon: Icon(
                          Icons.layers,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// AQI Value + Time
                  Row(
                    children: [
                      Text(
                        currentAqi['time'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                          backgroundColor: currentAqi['color'], radius: 6),
                      const SizedBox(width: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          "${currentAqi['value']} ${currentAqi['level']}",
                          key: ValueKey(_currentIndex),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Modes: Graph | Gauge | Wave
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: _viewMode == 0
                        ? _buildGraphView(currentAqi)
                        : _viewMode == 1
                        ? _buildGaugeView(currentAqi)
                        : _buildWaveView(currentAqi),
                  ),

                  const Divider(color: Colors.white24, thickness: 0.5, height: 28),

                  /// Suggestion
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      currentAqi['suggestion'],
                      key: ValueKey(_currentIndex),
                      style:
                      const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Graph View
  Widget _buildGraphView(Map<String, dynamic> currentAqi) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onHorizontalDragUpdate: (details) =>
                  _onHorizontalDragUpdate(details, constraints.maxWidth),
              child: CustomPaint(
                size: Size(constraints.maxWidth, 120),
                painter: _SmoothAqiGraphPainter(
                  data: aqiData,
                  progress: _progress,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildGradientLegend(),
      ],
    );
  }

  /// Circular Gauge View
  Widget _buildGaugeView(Map<String, dynamic> currentAqi) {
    return Center(
      child: ShaderMask(
        shaderCallback: (rect) {
          return const SweepGradient(
            startAngle: 0.0,
            endAngle: 3.14 * 2,
            colors: [Colors.green, Colors.yellow, Colors.orange, Colors.red, Colors.purple],
          ).createShader(rect);
        },
        child: CircularPercentIndicator(
          radius: 95.0,
          lineWidth: 16.0,
          percent: currentAqi['value'] / 500,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${currentAqi['value']}",
                style: const TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                currentAqi['level'],
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          backgroundColor: Colors.white12,
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
        ),
      ),
    );
  }

  /// Wave View with sine animation
  Widget _buildWaveView(Map<String, dynamic> currentAqi) {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 2 * math.pi),
              duration: const Duration(seconds: 3),
              onEnd: () => setState(() {}),
              builder: (context, value, child) {
                return CustomPaint(
                  size: Size(double.infinity, 120),
                  painter: _WavePainter(value, currentAqi['color']),
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${currentAqi['value']}",
                style: const TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                currentAqi['level'],
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Gradient Legend
  Widget _buildGradientLegend() {
    return Column(
      children: [
        Container(
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.red,
                Colors.purple
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Excellent",
                style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("Dangerous",
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

/// Smooth AQI line graph painter
class _SmoothAqiGraphPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final double progress;

  _SmoothAqiGraphPainter({required this.data, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final maxAqi =
    data.map<int>((d) => d['value']).reduce((a, b) => a > b ? a : b);

    final path = Path();
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final points = data.asMap().entries.map((entry) {
      int i = entry.key;
      var d = entry.value;
      final x = (i / (data.length - 1)) * size.width;
      final y = size.height - (d['value'] / maxAqi) * size.height;
      return Offset(x, y);
    }).toList();

    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final control = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
      path.quadraticBezierTo(p1.dx, p1.dy, control.dx, control.dy);
    }
    canvas.drawPath(path, linePaint);

    final indicatorX = progress * size.width;
    final currentIndex = (progress * (data.length - 1)).round();
    final indicatorY =
        size.height - (data[currentIndex]['value'] / maxAqi) * size.height;

    final glowPaint = Paint()
      ..color = data[currentIndex]['color'].withOpacity(0.4)
      ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 6);
    canvas.drawCircle(Offset(indicatorX, indicatorY), 10, glowPaint);

    final dotPaint = Paint()..color = data[currentIndex]['color'];
    canvas.drawCircle(Offset(indicatorX, indicatorY), 6, dotPaint);
    canvas.drawCircle(
        Offset(indicatorX, indicatorY), 3, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant _SmoothAqiGraphPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Painter for sine waves
class _WavePainter extends CustomPainter {
  final double phase;
  final Color color;

  _WavePainter(this.phase, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.6), color.withOpacity(0.2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    for (double x = 0; x <= size.width; x++) {
      double y = size.height / 2 +
          12 * math.sin((x / size.width * 2 * math.pi) + phase);
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.phase != phase;
  }
}
