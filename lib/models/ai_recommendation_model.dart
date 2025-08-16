// lib/models/ai_recommendation_model.dart

// Represents a single AI recommendation (song, food, or activity)
class AiRecommendation {
  final String category;
  final String title;
  final String subtitle;
  final String reason;
  final String imageUrl;

  AiRecommendation({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.reason,
    required this.imageUrl,
  });
}