// lib/views/widgets/health_outlook_card.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';

class HealthOutlookCard extends StatefulWidget {
  const HealthOutlookCard({super.key});

  @override
  State<HealthOutlookCard> createState() => _HealthOutlookCardState();
}

class _HealthOutlookCardState extends State<HealthOutlookCard> 
    with TickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  int _currentPage = 0;
  late final PageController _pageController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _riskController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _riskAnimation;

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

  final List<Map<String, dynamic>> outlookData = [
    {
      "title": "HEALTH CONDITIONS",
      "icon": PhosphorIcons.heart(PhosphorIconsStyle.fill),
      "conditions": [
        {"icon": PhosphorIcons.leaf(PhosphorIconsStyle.fill), "label": "Arthritis", "level": "High", "color": Colors.orange},
        {"icon": PhosphorIcons.syringe(PhosphorIconsStyle.fill), "label": "Sinus", "level": "Low", "color": Colors.green},
        {"icon": PhosphorIcons.virus(PhosphorIconsStyle.fill), "label": "Common Cold", "level": "Low", "color": Colors.green},
        {"icon": PhosphorIcons.wind(PhosphorIconsStyle.fill), "label": "Migraine", "level": "Moderate", "color": Colors.yellow},
        {"icon": PhosphorIcons.heart(PhosphorIconsStyle.fill), "label": "Asthma", "level": "High", "color": Colors.red},
      ]
    },
    {
      "title": "OUTDOOR ACTIVITIES",
      "icon": PhosphorIcons.personSimpleRun(PhosphorIconsStyle.fill),
      "conditions": [
        {"icon": PhosphorIcons.fishSimple(PhosphorIconsStyle.fill), "label": "Fishing", "level": "Poor", "color": Colors.red},
        {"icon": PhosphorIcons.personSimpleRun(PhosphorIconsStyle.fill), "label": "Running", "level": "Poor", "color": Colors.red},
        {"icon": PhosphorIcons.bicycle(PhosphorIconsStyle.fill), "label": "Biking", "level": "Good", "color": Colors.green},
        {"icon": PhosphorIcons.umbrella(PhosphorIconsStyle.fill), "label": "Beach & Pool", "level": "Good", "color": Colors.green},
        {"icon": PhosphorIcons.star(PhosphorIconsStyle.fill), "label": "Stargazing", "level": "Poor", "color": Colors.red},
      ]
    },
    {
      "title": "TRAVEL & COMMUTE",
      "icon": PhosphorIcons.airplaneTakeoff(PhosphorIconsStyle.fill),
      "conditions": [
        {"icon": PhosphorIcons.airplaneTakeoff(PhosphorIconsStyle.fill), "label": "Travel", "level": "Ideal", "color": Colors.green},
        {"icon": PhosphorIcons.car(PhosphorIconsStyle.fill), "label": "Driving", "level": "Fair", "color": Colors.yellow},
      ]
    },
    {
      "title": "HOME & GARDEN",
      "icon": PhosphorIcons.flower(PhosphorIconsStyle.fill),
      "conditions": [
        {"icon": PhosphorIcons.flower(PhosphorIconsStyle.fill), "label": "Lawn Mowing", "level": "Poor", "color": Colors.red},
        {"icon": PhosphorIcons.tree(PhosphorIconsStyle.fill), "label": "Composting", "level": "Great", "color": Colors.green},
        {"icon": PhosphorIcons.sun(PhosphorIconsStyle.fill), "label": "Entertaining", "level": "Good", "color": Colors.green},
      ]
    },
    {
      "title": "PEST ACTIVITY",
      "icon": PhosphorIcons.bug(PhosphorIconsStyle.fill),
      "conditions": [
        {"icon": PhosphorIcons.bug(PhosphorIconsStyle.fill), "label": "Mosquito Activity", "level": "Extreme", "color": Colors.red},
        {"icon": PhosphorIcons.bugBeetle(PhosphorIconsStyle.fill), "label": "Indoor Pest", "level": "Very High", "color": Colors.red},
        {"icon": PhosphorIcons.bugBeetle(PhosphorIconsStyle.fill), "label": "Outdoor Pest", "level": "Extreme", "color": Colors.red},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedDate = DateTime.now();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _riskController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack));
    _riskAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _riskController, curve: Curves.easeOut),
    );
    
    _fadeController.forward();
    _slideController.forward();
    _riskController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _riskController.dispose();
    super.dispose();
  }

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

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    HapticFeedback.lightImpact();
  }

  void _nextPage() {
    if (_currentPage < outlookData.length - 1) {
      setState(() {
        _currentPage++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.red.withOpacity(0.1),
                    Colors.orange.withOpacity(0.1),
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
                      _buildCalendar(),
                      const SizedBox(height: 20),
                      _buildRiskBar(),
                      const SizedBox(height: 20),
                      _buildOutlookSection(),
                    ],
                  ),
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
            color: Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.health_and_safety,
            color: Colors.red,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          "HEALTH OUTLOOK",
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
            color: Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.withOpacity(0.3)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.red,
                size: 12,
              ),
              SizedBox(width: 4),
              Text(
                "10D",
                style: TextStyle(
                  color: Colors.red,
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

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Risk Calendar",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index));
                final riskProfile = _getRiskProfileForDate(date);
                final isSelected = _selectedDate.day == date.day;
                
                return GestureDetector(
                  onTap: () => _selectDate(date),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected 
                          ? riskProfile['color'].withOpacity(0.3)
                          : Colors.white.withOpacity(0.05),
                      border: Border.all(
                        color: isSelected 
                            ? riskProfile['color']
                            : Colors.white.withOpacity(0.1),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('E').format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: riskProfile['color'],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBar() {
    final riskProfile = _getRiskProfileForDate(_selectedDate);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Risk Level",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: riskProfile['color'].withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: riskProfile['color'].withOpacity(0.3)),
                ),
                child: Text(
                  riskProfile['level'],
                  style: TextStyle(
                    color: riskProfile['color'],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: _riskAnimation,
            builder: (context, child) {
              return Container(
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (riskProfile['value'] * _riskAnimation.value).clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        colors: [
                          riskProfile['color'].withOpacity(0.8),
                          riskProfile['color'],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOutlookSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              outlookData[_currentPage]['icon'],
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              outlookData[_currentPage]['title'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: _previousPage,
                  icon: Icon(
                    Icons.chevron_left,
                    color: _currentPage > 0 ? Colors.white : Colors.white.withOpacity(0.3),
                    size: 20,
                  ),
                ),
                Text(
                  "${_currentPage + 1}/${outlookData.length}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                IconButton(
                  onPressed: _nextPage,
                  icon: Icon(
                    Icons.chevron_right,
                    color: _currentPage < outlookData.length - 1 ? Colors.white : Colors.white.withOpacity(0.3),
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
                 SizedBox(
           height: 100,
           child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: outlookData.length,
            itemBuilder: (context, pageIndex) {
              final conditions = outlookData[pageIndex]['conditions'] as List;
                             return GridView.builder(
                 physics: const BouncingScrollPhysics(),
                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   childAspectRatio: 3.2,
                   crossAxisSpacing: 4,
                   mainAxisSpacing: 4,
                 ),
                itemCount: conditions.length,
                itemBuilder: (context, index) {
                  final condition = conditions[index];
                                     return Container(
                     padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: condition['color'].withOpacity(0.1),
                      border: Border.all(color: condition['color'].withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                                                 Icon(
                           condition['icon'],
                           color: condition['color'],
                           size: 12,
                         ),
                                                 const SizedBox(width: 4),
                        Expanded(
                                                                  child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Flexible(
                         child: Text(
                           condition['label'],
                           style: const TextStyle(
                             color: Colors.white,
                             fontSize: 10,
                             fontWeight: FontWeight.bold,
                           ),
                           overflow: TextOverflow.ellipsis,
                         ),
                       ),
                       Flexible(
                         child: Text(
                           condition['level'],
                           style: TextStyle(
                             color: condition['color'],
                             fontSize: 8,
                             fontWeight: FontWeight.bold,
                           ),
                           overflow: TextOverflow.ellipsis,
                         ),
                       ),
                     ],
                   ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}