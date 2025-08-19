import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';

class HealthOutlookCard extends StatefulWidget {
  const HealthOutlookCard({super.key});

  @override
  State<HealthOutlookCard> createState() => _HealthOutlookCardState();
}

class _HealthOutlookCardState extends State<HealthOutlookCard> {
  DateTime _selectedDate = DateTime.now();
  int _currentPage = 0;

  final List<Map<String, dynamic>> outlookData = [
    {
      "title": "10-DAY HEALTH OUTLOOK",
      "conditions": [
        {"icon": PhosphorIcons.leaf(), "label": "Arthritis", "level": "High", "color": Colors.orange},
        {"icon": PhosphorIcons.syringe(), "label": "Sinus", "level": "Low", "color": Colors.green},
        {"icon": PhosphorIcons.virus(), "label": "Common Cold", "level": "Low", "color": Colors.green},
        {"icon": PhosphorIcons.wind(), "label": "Migraine", "level": "Moderate", "color": Colors.yellow},
        {"icon": PhosphorIcons.heart(), "label": "Asthma", "level": "High", "color": Colors.red},
      ]
    },
    {
      "title": "10-DAY OUTDOOR ACTIVITIES OUTLOOK",
      "conditions": [
        {"icon": PhosphorIcons.fishSimple(), "label": "Fishing", "level": "Poor", "color": Colors.red},
        {"icon": PhosphorIcons.personSimpleRun(), "label": "Running", "level": "Poor", "color": Colors.red},
        {"icon": PhosphorIcons.bicycle(), "label": "Biking", "level": "Good", "color": Colors.green},
        {"icon": PhosphorIcons.umbrella(), "label": "Beach & Pool", "level": "Good", "color": Colors.green},
        {"icon": PhosphorIcons.star(), "label": "Stargazing", "level": "Poor", "color": Colors.red},
      ]
    },
    {
      "title": "10-DAY TRAVEL & COMMUTE OUTLOOK",
      "conditions": [
        {"icon": PhosphorIcons.airplaneTakeoff(), "label": "Travel", "level": "Ideal", "color": Colors.green},
        {"icon": PhosphorIcons.car(), "label": "Driving", "level": "Fair", "color": Colors.yellow},
      ]
    },
    {
      "title": "10-DAY HOME & GARDEN OUTLOOK",
      "conditions": [
        {"icon": PhosphorIcons.flower(), "label": "Lawn Mowing", "level": "Poor", "color": Colors.red},
        {"icon": PhosphorIcons.tree(), "label": "Composting", "level": "Great", "color": Colors.green},
        {"icon": PhosphorIcons.sun(), "label": "Entertaining", "level": "Good", "color": Colors.green},
      ]
    },
    {
      "title": "10-DAY PESTS OUTLOOK",
      "conditions": [
        {"icon": PhosphorIcons.bug(), "label": "Mosquito Activity", "level": "Extreme", "color": Colors.red},
        {"icon": PhosphorIcons.bugBeetle(), "label": "Indoor Pest", "level": "Very High", "color": Colors.red},
        {"icon": PhosphorIcons.bugBeetle(), "label": "Outdoor Pest", "level": "Extreme", "color": Colors.red},
      ]
    },
    {
      "title": "10-DAY ALLERGIES OUTLOOK",
      "conditions": [
        {"icon": PhosphorIcons.flower(), "label": "Dust & Dander", "level": "Extreme", "color": Colors.red},
      ]
    },
  ];

  void _onSwipe(DragEndDetails details) {
    if (details.primaryVelocity == 0) return;
    if (details.primaryVelocity!.abs() < 200) return;

    int newPage = _currentPage;
    if (details.primaryVelocity! < 0) {
      newPage = (_currentPage + 1).clamp(0, outlookData.length - 1);
    } else {
      newPage = (_currentPage - 1).clamp(0, outlookData.length - 1);
    }
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.3),
      child: GestureDetector(
        onHorizontalDragEnd: _onSwipe,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                outlookData[_currentPage]['title'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const Divider(),
              _buildCalendar(),
              const SizedBox(height: 16),
              _buildRiskLevelBar(),
              const SizedBox(height: 18),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildConditionsList(
                  key: ValueKey<int>(_currentPage),
                  conditions: outlookData[_currentPage]['conditions'],
                ),
              ),
              const SizedBox(height: 8),
              _buildPageIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConditionsList({Key? key, required List<dynamic> conditions}) {
    return Column(
      key: key,
      children: conditions
          .map((condition) => Column(
        children: [
          _buildConditionRow(condition),
          if (conditions.last != condition)
            Divider(color: Colors.white.withOpacity(0.09), height: 1),
        ],
      ))
          .toList(),
    );
  }

  Widget _buildCalendar() {
    final dayHeaders = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday % 7));

    return Column(
      children: [
        Row(
          children: dayHeaders
              .map((day) => Expanded(
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ))
              .toList(),
        ),
        const SizedBox(height: 4),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
          ),
          itemCount: 14,
          itemBuilder: (context, index) {
            final date = startOfWeek.add(Duration(days: index));
            final isSelected = date.day == _selectedDate.day &&
                date.month == _selectedDate.month &&
                date.year == _selectedDate.year;

            final isEnabled = date.isBefore(today.add(const Duration(days: 10)));

            Color bgColor;
            Color textColor;

            if (isSelected) {
              bgColor = Colors.white;
              textColor = Colors.black;
            } else if (isEnabled) {
              bgColor = const Color(0xFF009688);
              textColor = Colors.white;
            } else {
              bgColor = Colors.grey.shade800;
              textColor = Colors.grey.shade500;
            }

            return GestureDetector(
              onTap: isEnabled ? () => setState(() => _selectedDate = date) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRiskLevelBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("LOW", style: TextStyle(color: Colors.white70, fontSize: 12)),
              Text("EXTREME", style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.yellow, Colors.orange, Colors.red],
              ),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 1))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionRow(Map<String, dynamic> condition) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 2.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[800],
            child: Icon(condition['icon'], color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              condition['label'],
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: condition['color'].withOpacity(0.21),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              condition['level'],
              style: TextStyle(
                  color: condition['color'],
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(backgroundColor: condition['color'], radius: 7),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(outlookData.length, (index) {
        bool isActive = _currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          width: isActive ? 17 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isActive ? Colors.blueAccent : Colors.grey[600],
            boxShadow: isActive
                ? [BoxShadow(color: Colors.blueAccent.withOpacity(0.32), blurRadius: 7)]
                : [],
          ),
        );
      }),
    );
  }
}