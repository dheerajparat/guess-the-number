class TodoItem {
  String id;
  String title;
  bool done;
  DateTime createdAt;

  TodoItem({
    required this.id,
    required this.title,
    this.done = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'done': done,
    'createdAt': createdAt.toIso8601String(),
  };

  factory TodoItem.fromJson(Map<String, dynamic> j) => TodoItem(
    id: j['id'] as String,
    title: j['title'] as String,
    done: j['done'] as bool? ?? false,
    createdAt: DateTime.parse(j['createdAt'] as String),
  );
}
