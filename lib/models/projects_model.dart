class ProjectModel {
  final int id;
  final String title;
  final String description;
  String status;
  final int userId;
  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.userId,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      description: json['body'],
      status: ['Pending', 'In Progress', 'Done'][json['id'] % 3],
      userId: json['userId'],
    );
  }
}
