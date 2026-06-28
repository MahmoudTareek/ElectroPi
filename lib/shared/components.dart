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
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
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
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    enabled: isClickable,

    style: TextStyle(color: isDark ? Colors.white : Colors.black),

    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    onTap: onTap,
    validator: validate,

    decoration: InputDecoration(
      filled: true,

      fillColor: isDark ? const Color(0xff1E1E1E) : Colors.white,

      labelText: label,

      labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.grey[500]),

      prefixIcon: prefix != null
          ? Icon(prefix, color: isDark ? Colors.white70 : Colors.grey)
          : null,

      suffixIcon: suffix != null
          ? IconButton(onPressed: suffixPrssed, icon: Icon(suffix))
          : null,

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
    ),
  );
}

Widget buildBoardingItem(BuildContext context, BoardingModel model) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  final size = MediaQuery.of(context).size;

  final width = size.width;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width * .06),

    child: Column(
      children: [
        Expanded(
          flex: 3,

          child: Center(
            child: Image.asset(
              model.image,

              width: width * .75,

              fit: BoxFit.contain,
            ),
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                model.title,

                style: TextStyle(
                  fontSize: width < 360 ? 22 : 24,

                  fontWeight: FontWeight.bold,

                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: width < 360 ? 8 : 12),

              Text(
                model.body,

                style: TextStyle(
                  fontSize: width < 360 ? 15 : 16,

                  height: 1.5,

                  color: isDark ? Colors.white70 : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Color getStatusColor(String status) {
  switch (status) {
    case "Done":
      return Colors.green;

    case "In Progress":
      return Colors.blue;

    default:
      return Colors.orange;
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1E1E1E) : Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
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

                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,

                    fontWeight: FontWeight.bold,

                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  project.description,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.grey,
                  ),
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
    );
  }
}

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;

  const TaskCard({super.key, required this.task, required this.onTap});

  Color get priorityColor {
    return task.priority == "High"
        ? Colors.red
        : task.priority == "Medium"
        ? Colors.orange
        : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1E1E1E) : Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,

            blurRadius: 8,

            offset: const Offset(0, 3),
          ),
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
                    : Colors.transparent,

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

                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,

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
