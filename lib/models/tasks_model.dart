class TaskModel {
  String title;
  String priority;
  String status;
  bool selected;

  TaskModel({
    required this.title,
    required this.priority,
    required this.status,
    this.selected = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['todo'] ?? '',
      priority: 'Medium',
      status: json['completed'] ? 'Done' : 'Pending',
      selected: json['completed'] ?? false,
    );
  }
}