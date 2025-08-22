// lib/views/widgets/ai_suggestion_card.dart

import 'package:flutter/material.dart';

class AiSuggestionCard extends StatelessWidget {
  const AiSuggestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "AI Suggestions",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Based on the cloudy weather, here are some suggestions for your evening:",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.music_note, color: Colors.amber, size: 30),
                    SizedBox(height: 5),
                    Text("Lo-fi Beats", style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.local_fire_department, color: Colors.orange, size: 30),
                    SizedBox(height: 5),
                    Text("Hot Soup", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}