// lib/views/widgets/hourly_detail_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HourlyDetailView extends StatefulWidget {
  final String time;
  final String day;
  final Map<String, dynamic> data;

  const HourlyDetailView({
    super.key,
    required this.time,
    required this.day,
    required this.data,
  });

  @override
  State<HourlyDetailView> createState() => _HourlyDetailViewState();
}

class _HourlyDetailViewState extends State<HourlyDetailView> 
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack));
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _slideController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

     @override
   Widget build(BuildContext context) {
     return DraggableScrollableSheet(
       initialChildSize: 0.75,
       maxChildSize: 0.75,
       minChildSize: 0.75,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF1B1B1D),
                const Color(0xFF2D2D30),
                const Color(0xFF1B1B1D),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildHandle(),
              _buildHeader(),
                             Expanded(
                 child: FadeTransition(
                   opacity: _fadeAnimation,
                   child: SlideTransition(
                     position: _slideAnimation,
                     child: SingleChildScrollView(
                       controller: controller,
                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
                       child: Column(
                         children: [
                           _buildMainWeatherInfo(),
                           const SizedBox(height: 20),
                           _buildWeatherSummary(),
                           const SizedBox(height: 20),
                           _buildDetailGrid(),
                           const SizedBox(height: 20),
                         ],
                       ),
                     ),
                   ),
                 ),
               ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.time}, ${widget.day}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hourly Forecast',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 20),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

     Widget _buildMainWeatherInfo() {
     return Container(
       padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo.withOpacity(0.2),
            Colors.purple.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    widget.data['icon'] as IconData,
                    size: 48,
                    color: const Color(0xFF0095FF),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                             Text(
                 '${widget.data['temp']}',
                 style: const TextStyle(
                   fontSize: 64,
                   fontWeight: FontWeight.w300,
                   color: Colors.white,
                   height: 1,
                 ),
               ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  '°F',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      PhosphorIcons.drop(PhosphorIconsStyle.fill),
                      color: const Color(0xFF00BFFF),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${widget.data['precipitation']}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

     Widget _buildWeatherSummary() {
     return Container(
       padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.white.withOpacity(0.7),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Weather Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Mostly cloudy with light winds. Humidity levels are high, making it feel warmer than the actual temperature.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailGrid() {
    final details = (widget.data['details'] as Map<String, dynamic>?) ?? {};
    final detailEntries = details.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.analytics_outlined,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Detailed Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
                 const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2,
             childAspectRatio: 3.5,
             crossAxisSpacing: 4,
             mainAxisSpacing: 4,
           ),
          itemCount: detailEntries.length,
          itemBuilder: (context, index) {
            final entry = detailEntries[index];
            final String value = entry.value.toString();
            final Color valueColor = _getValueColor(value);
            final IconData icon = _getDetailIcon(entry.key);

                         return Container(
               padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
                             child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                                     Row(
                     children: [
                       Icon(
                         icon,
                         color: Colors.white.withOpacity(0.7),
                         size: 12,
                       ),
                                                const SizedBox(width: 3),
                      Expanded(
                                                 child: Text(
                           entry.key,
                           style: TextStyle(
                             fontSize: 10,
                             color: Colors.white.withOpacity(0.7),
                             fontWeight: FontWeight.w500,
                           ),
                           overflow: TextOverflow.ellipsis,
                         ),
                      ),
                    ],
                  ),
                                     Text(
                     value,
                     style: TextStyle(
                       fontSize: 12,
                       color: valueColor,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Color _getValueColor(String value) {
    final lowerValue = value.toLowerCase();
    if (lowerValue.contains('poor') || lowerValue.contains('extreme')) {
      return Colors.red;
    } else if (lowerValue.contains('fair') || lowerValue.contains('moderate')) {
      return Colors.orange;
    } else if (lowerValue.contains('good') || lowerValue.contains('ideal')) {
      return Colors.green;
    } else if (lowerValue.contains('humid')) {
      return Colors.blue;
    } else {
      return Colors.white;
    }
  }

  IconData _getDetailIcon(String key) {
    switch (key.toLowerCase()) {
      case 'realfeel®':
        return Icons.thermostat;
      case 'humidity':
        return Icons.water_drop;
      case 'indoor humidity':
        return Icons.home;
      case 'air quality':
        return Icons.air;
      case 'wind':
        return Icons.air;
      case 'wind gusts':
        return Icons.air;
             case 'rain probability':
         return PhosphorIcons.cloudRain(PhosphorIconsStyle.fill);
      case 'cloud cover':
        return Icons.cloud;
      case 'dew point':
        return Icons.water_drop;
      case 'visibility':
        return Icons.visibility;
      case 'cloud ceiling':
        return Icons.cloud;
      default:
        return Icons.info_outline;
    }
  }
}