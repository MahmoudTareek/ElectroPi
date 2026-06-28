class TaskModel {
  final int id;
  final String title;
  String status;
  final String priority;
  bool selected;
  TaskModel({
    required this.id,
    required this.title,
    required this.status,
    required this.priority,
    this.selected = false,
  });
  factory TaskModel.fromJson(
      Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['todo'],
      status:
          json['completed']
              ? 'Done'
              : 'Pending',
      priority: [
        'Low',
        'Medium',
        'High'
      ][json['id'] % 3],
    );
  }
}