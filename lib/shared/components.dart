// Components file I made to avoid code repetition and make the code more organized and reusable. Moreover it makes it easier to maintain and update the code in the future.
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:electropi/models/tasks_model.dart';
import 'package:flutter/material.dart';
// import 'package:electropi/modules/details/detail_screen.dart';

const primaryColor = Color(0xFF04A49A);
const secondaryColor = Color(0xFF283943);
// A reusable button widget with customizable properties, used in login screen as login button, profile screens as update and logout buttons
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

// A reusable form field widget with customizable properties, used in login, register and profile screens
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
    /// شكل الخلفية
    filled: true,
    fillColor: Colors.white,

    /// النص اللي فوق
    labelText: label,

    floatingLabelBehavior: FloatingLabelBehavior.auto,

    labelStyle: TextStyle(color: Colors.grey[500], fontSize: 14),

    /// الايقونة
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

    /// العادي
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),

      borderSide: BorderSide(color: Colors.grey.shade300),
    ),

    /// لما يركز
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),

      borderSide: BorderSide(color: primaryColor, width: 1.5),
    ),

    /// بدون فوكس
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

class ProjectCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final IconData icon;
  final Color iconColor;

  const ProjectCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/projectDetails', arguments: title);
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
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: status == "Active"
                    ? Colors.green.withOpacity(.15)
                    : status == "Pending"
                    ? Colors.orange.withOpacity(.15)
                    : Colors.blue.withOpacity(.15),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: status == "Active"
                      ? Colors.green
                      : status == "Pending"
                      ? Colors.orange
                      : Colors.blue,
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

                color: task.isSelected ? primaryColor : Colors.white,

                border: Border.all(color: primaryColor),
              ),

              child: task.isSelected
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
              color: statusColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              task.status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}