class DiaryEntry {
  String id;
  DateTime date;
  List<String> output;
  List<String> friction;
  List<String> correction;
  String pressureLine;

  DiaryEntry({
    required this.id,
    required this.date,
    required this.output,
    required this.friction,
    required this.correction,
    required this.pressureLine,
  });
  DiaryEntry copyWith({
    String? id,
    DateTime? date,
    List<String>? output,
    List<String>? friction,
    List<String>? correction,
    String? pressureLine,
  }) {
    return DiaryEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      output: output ?? this.output,
      friction: friction ?? this.friction,
      correction: correction ?? this.correction,
      pressureLine: pressureLine ?? this.pressureLine,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'output': output,
      'friction': friction,
      'correction': correction,
      'pressureLine': pressureLine,
    };
  }

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      output: List<String>.from(json['output'] ?? []),
      friction: List<String>.from(json['friction'] ?? []),
      correction: List<String>.from(json['correction'] ?? []),
      pressureLine: json['pressureLine'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'DiaryEntry(id: $id, date: $date, output: $output, friction: $friction, correction: $correction, pressureLine: $pressureLine)';
  }
}
