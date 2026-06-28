import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/models/on_boarding_model.dart';
import 'package:electropi/models/projects_model.dart';
import 'package:electropi/models/tasks_model.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF04A49A);
const secondaryColor = Color(0xFF283943);
Widget defaultButton({
  required VoidCallback function,
  bool isDisabled = false,
  double width = double.infinity,
  Color background = primaryColor,
  bool isUpperCase = false,
  double radius = 0.0,
  required String text,
}) => Container(
  width: width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    ),
  ),
);

Widget defaultFormField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  Function(String)? onSubmit,
  Function(String)? onChange,
  VoidCallback? onTap,
  required String? Function(String?) validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPrssed,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: label,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    labelStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
    prefixIcon: prefix != null
        ? Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(prefix, color: Colors.grey[700]),
          )
        : null,
    prefixIconConstraints: const BoxConstraints(minWidth: 50),
    suffixIcon: suffix != null
        ? IconButton(onPressed: suffixPrssed, icon: Icon(suffix))
        : null,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
    errorMaxLines: 3,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),

      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),

      borderSide: BorderSide(color: primaryColor, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),

      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.red),
    ),
  ),
);

Widget buildBoardingItem(BoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 3,
        child: Center(
          child: Image.asset(
            model.image,
            width: 420,
            height: 420,
            fit: BoxFit.contain,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(model.body, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    ],
  );
}

Color getStatusColor(String status) {
  switch (status) {
    case 'Done':
      return Colors.green;

    case 'Pending':
      return Colors.orange;

    case 'In Progress':
      return Colors.blue;

    default:
      return Colors.grey;
  }
}

Color getStatusBackground(String status) {
  return getStatusColor(status).withOpacity(.15);
}

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final IconData icon;
  final Color iconColor;
  const ProjectCard({
    super.key,
    required this.project,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProjectCubit.get(context).getProjectTasks(project.userId).then((_) {
          Navigator.pushNamed(context, '/projectDetails', arguments: project);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    project.description,
                    maxLines: 1,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: getStatusBackground(project.status),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                project.status,
                style: TextStyle(
                  color: getStatusColor(project.status),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;
  const TaskCard({super.key, required this.task, required this.onTap});
  Color get statusColor {
    switch (task.status) {
      case "Done":
        return Colors.green;
      case "In Progress":
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }

  Color get priorityColor {
    return task.priority == "High"
        ? Colors.red
        : task.priority == "Medium"
        ? Colors.orange
        : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (task.selected || task.status == "Done")
                    ? primaryColor
                    : Colors.white,
                border: Border.all(color: primaryColor),
              ),
              child: (task.selected || task.status == "Done")
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  task.priority,
                  style: TextStyle(
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: getStatusBackground(task.status),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              task.status,
              style: TextStyle(
                color: getStatusColor(task.status),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
