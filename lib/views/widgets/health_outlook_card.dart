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
  late final PageController _pageController;

  // ✅ ADDED: Mock data with a 'value' (0.0 to 1.0) to represent daily risk levels.
  // This powers the new interactive features.
  final List<Map<String, dynamic>> dailyRiskData = [
    {"dayOffset": 0, "level": "High", "color": Colors.orange, "value": 0.7},
    {"dayOffset": 1, "level": "High", "color": Colors.orange, "value": 0.75},
    {"dayOffset": 2, "level": "Extreme", "color": Colors.red, "value": 0.9},
    {"dayOffset": 3, "level": "Moderate", "color": Colors.yellow, "value": 0.5},
    {"dayOffset": 4, "level": "Low", "color": Colors.green, "value": 0.1},
    {"dayOffset": 5, "level": "Low", "color": Colors.green, "value": 0.15},
    {"dayOffset": 6, "level": "Moderate", "color": Colors.yellow, "value": 0.55},
    {"dayOffset": 7, "level": "High", "color": Colors.orange, "value": 0.8},
    {"dayOffset": 8, "level": "Extreme", "color": Colors.red, "value": 0.95},
    {"dayOffset": 9, "level": "Extreme", "color": Colors.red, "value": 1.0},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedDate = DateTime.now(); // Ensure today is selected initially
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ✅ ADDED: Helper to get the full risk profile (color, value) for a given date.
  Map<String, dynamic> _getRiskProfileForDate(DateTime date) {
    final today = DateTime.now();
    final todayWithoutTime = DateTime(today.year, today.month, today.day);
    final dateWithoutTime = DateTime(date.year, date.month, date.day);
    final difference = dateWithoutTime.difference(todayWithoutTime).inDays;

    return dailyRiskData.firstWhere(
          (data) => data['dayOffset'] == difference,
      orElse: () => {"color": Colors.grey.shade700, "value": 0.0, "level": "N/A"},
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: 280,
              child: PageView.builder(
                controller: _pageController,
                itemCount: outlookData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildConditionsList(
                    conditions: outlookData[index]['conditions'],
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            _buildPageIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionsList({required List<dynamic> conditions}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: conditions.length,
      itemBuilder: (context, index) {
        return _buildConditionRow(conditions[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(color: Colors.white.withOpacity(0.09), height: 1);
      },
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

            final isEnabled = date.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
                date.isBefore(DateTime.now().add(const Duration(days: 10)));

            Color bgColor;
            Color textColor;

            if (isSelected) {
              bgColor = Colors.white;
              textColor = Colors.black;
            } else if (isEnabled) {
              final riskProfile = _getRiskProfileForDate(date);
              bgColor = riskProfile['color'];
              textColor = (bgColor == Colors.yellow) ? Colors.black87 : Colors.white;
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
                    border: isSelected ? Border.all(color: Colors.blueAccent, width: 2) : null
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

  // ✅ EDITED: This widget is now a state-of-the-art interactive risk bar.
  Widget _buildRiskLevelBar() {
    final riskProfile = _getRiskProfileForDate(_selectedDate);
    final double riskValue = riskProfile['value']?.toDouble() ?? 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              // Calculate thumb position, ensuring it stays within the bar's bounds
              final thumbPosition = (barWidth - 16) * riskValue; // 16 is thumb's width

              return SizedBox(
                height: 20, // Increased height to comfortably fit the thumb
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // The gradient bar
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.green,
                            Colors.yellow,
                            Colors.orange,
                            Colors.red,
                          ],
                        ),
                      ),
                    ),
                    // The animated thumb indicator
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      left: thumbPosition,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withOpacity(0.5), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
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
        return GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          child: AnimatedContainer(
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
          ),
        );
      }),
    );
  }
}