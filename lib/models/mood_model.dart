class Mood {
  final String emoji;
  final String label;
  final int energyLevel; // Slider value (1–5)
  final bool stressed; // Yes/No toggle
  final List<String> emotions; // Multi-select tags like "Anxious," "Calm."

  Mood({
    required this.emoji,
    required this.label,
    required this.energyLevel,
    required this.stressed,
    required this.emotions,
  });

  // For storing data locally, you can convert it to/from JSON.
  Map<String, dynamic> toJson() => {
    'emoji': emoji,
    'label': label,
    'energyLevel': energyLevel,
    'stressed': stressed,
    'emotions': emotions,
  };

  factory Mood.fromJson(Map<String, dynamic> json) {
    return Mood(
      emoji: json['emoji'],
      label: json['label'],
      energyLevel: json['energyLevel'],
      stressed: json['stressed'],
      emotions: List<String>.from(json['emotions']),
    );
  }
}
