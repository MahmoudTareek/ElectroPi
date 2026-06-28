import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final titleController = TextEditingController();

  String selectedPriority = "Medium";
  String selectedStatus = "In Progress";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xff1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add New Task",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Task Title",
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: "e.g. Design landing page",
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                  filled: true,
                  fillColor: isDark ? const Color(0xff2A2A2A) : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "Status",
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: [
                  statusChip("Pending"),
                  statusChip("In Progress"),
                  statusChip("Done"),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                "Priority",
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: [
                  priorityChip("Low", Colors.green),
                  priorityChip("Medium", Colors.orange),
                  priorityChip("High", Colors.red),
                ],
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) return;
                    ProjectCubit.get(context).addTask(
                      title: titleController.text.trim(),
                      priority: selectedPriority,
                      status: selectedStatus,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Create Task",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statusChip(String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selected = selectedStatus == value;
    Color color;
    switch (value) {
      case "Done":
        color = Colors.green;
        break;
      case "In Progress":
        color = Colors.blue;
        break;
      default:
        color = Colors.orange;
    }
    return ChoiceChip(
      label: Text(
        value,
        style: TextStyle(
          color: selected
              ? color
              : isDark
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: selected,
      selectedColor: color.withOpacity(.12),
      backgroundColor: isDark ? const Color(0xff2A2A2A) : Colors.grey.shade100,
      side: BorderSide(
        color: selected
            ? color.withOpacity(.25)
            : isDark
            ? Colors.grey.shade700
            : Colors.grey.shade300,
      ),
      checkmarkColor: color,
      onSelected: (_) {
        setState(() {
          selectedStatus = value;
        });
      },
    );
  }

  Widget priorityChip(String value, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selected = selectedPriority == value;
    return ChoiceChip(
      label: Text(
        value,
        style: TextStyle(
          color: selected
              ? color
              : isDark
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: selected,
      selectedColor: color.withOpacity(.12),
      backgroundColor: isDark ? const Color(0xff2A2A2A) : Colors.grey.shade100,
      side: BorderSide(
        color: selected
            ? color.withOpacity(.25)
            : isDark
            ? Colors.grey.shade700
            : Colors.grey.shade300,
      ),
      checkmarkColor: color,
      onSelected: (_) {
        setState(() {
          selectedPriority = value;
        });
      },
    );
  }
}
