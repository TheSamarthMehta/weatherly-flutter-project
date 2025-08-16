// lib/views/widgets/hourly_detail_view.dart

import 'package:flutter/material.dart';

class HourlyDetailView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // ✅ FIX: Increased the size to make the sheet taller and reduce scrolling.
    return DraggableScrollableSheet(
      initialChildSize: 0.95, // Was 0.8, now it's taller
      maxChildSize: 0.95,   // Set max size to the same to prevent resizing
      minChildSize: 0.5,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1B1B1D),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      '$time, $day',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable list of details
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    _buildMainWeatherInfo(),
                    const SizedBox(height: 16),
                    ..._buildDetailRows(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainWeatherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(data['icon'] as IconData, size: 60, color: const Color(0xFF0095FF)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${data['temp']}',
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w300, color: Colors.white, height: 1),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                '°F',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white54),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.water_drop_outlined, color: Colors.white54, size: 16),
            const SizedBox(width: 4),
            const Text('Precipitation: 7%', style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
        const SizedBox(height: 4),
        const Text('Mostly cloudy', style: TextStyle(fontSize: 18, color: Colors.white)),
      ],
    );
  }

  List<Widget> _buildDetailRows() {
    final details = (data['details'] as Map<String, dynamic>?) ?? {};
    final detailEntries = details.entries.toList();

    return [
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: detailEntries.length,
        separatorBuilder: (context, index) => const Divider(color: Colors.white24, height: 1),
        itemBuilder: (context, index) {
          final entry = detailEntries[index];
          final String value = entry.value.toString();
          final Color valueColor;

          if (value.toLowerCase() == 'poor') {
            valueColor = Colors.orange;
          } else if (value.toLowerCase() == 'fair') {
            valueColor = Colors.green;
          } else {
            valueColor = Colors.white;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: valueColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      )
    ];
  }
}