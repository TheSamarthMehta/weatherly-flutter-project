import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';

class HealthOutlookCard extends StatefulWidget {
  const HealthOutlookCard({super.key});

  @override
  State<HealthOutlookCard> createState() => _HealthOutlookCardState();
}

class _HealthOutlookCardState extends State<HealthOutlookCard> {
  late final PageController _pageController;
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
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.98);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
        child: Column(
          children: [
            SizedBox(
              height: 380,
              child: PageView.builder(
                controller: _pageController,
                itemCount: outlookData.length,
                onPageChanged: (index) =>
                    setState(() => _currentPage = index),
                itemBuilder: (context, index) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _buildOutlookPage(outlookData[index]),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildPageIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlookPage(Map<String, dynamic> pageData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pageData['title'],
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        _buildCalendar(),
        const SizedBox(height: 16),
        _buildRiskLevelBar(),
        const SizedBox(height: 18),
        // Scrollable condition list to avoid overflow
        Container(
          height: 155, // Change as needed, fits 4-5 items before scrolling
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: (pageData['conditions'] as List).length,
            separatorBuilder: (_, __) =>
                Divider(color: Colors.white.withOpacity(0.09), height: 1),
            itemBuilder: (context, index) =>
                _buildConditionRow(pageData['conditions'][index]),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index));
          final isToday = date.day == DateTime.now().day && date.month == DateTime.now().month;
          final isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;

          return GestureDetector(
            onTap: () => setState(() => _selectedDate = date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: 54,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent : Colors.grey[850],
                borderRadius: BorderRadius.circular(14),
                border: isToday ? Border.all(color: Colors.blueAccent, width: 2) : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date).substring(0, 3).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.78),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRiskLevelBar() {
    return Column(
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
