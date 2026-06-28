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
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
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
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add New Task",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Task Title"),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "e.g. Design landing page",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text("Status"),
              const SizedBox(height: 10),
              Row(
                children: [
                  statusChip("Pending"),
                  const SizedBox(width: 8),
                  statusChip("In Progress"),
                  const SizedBox(width: 8),
                  statusChip("Done"),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Priority"),
              const SizedBox(height: 10),
              Row(
                children: [
                  priorityChip("Low", Colors.green),
                  const SizedBox(width: 8),
                  priorityChip("Medium", Colors.orange),
                  const SizedBox(width: 8),
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
    final selected = selectedStatus == value;
    Color statusColor;
    switch (value) {
      case "Done":
        statusColor = Colors.green;
        break;
      case "In Progress":
        statusColor = Colors.blue;
        break;
      default:
        statusColor = Colors.orange;
    }
    return ChoiceChip(
      label: Text(
        value,
        style: TextStyle(
          color: selected ? statusColor : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: selected,
      selectedColor: statusColor.withOpacity(.12),
      backgroundColor: Colors.grey.shade100,
      side: BorderSide(
        color: selected ? statusColor.withOpacity(.25) : Colors.grey.shade300,
      ),
      checkmarkColor: statusColor,
      onSelected: (_) {
        setState(() {
          selectedStatus = value;
        });
      },
    );
  }

  Widget priorityChip(String value, Color color) {
    final selected = selectedPriority == value;
    return ChoiceChip(
      label: Text(
        value,
        style: TextStyle(
          color: selected ? color : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: selected,
      selectedColor: color.withOpacity(.12),
      backgroundColor: Colors.grey.shade100,
      side: BorderSide(
        color: selected ? color.withOpacity(.25) : Colors.grey.shade300,
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
