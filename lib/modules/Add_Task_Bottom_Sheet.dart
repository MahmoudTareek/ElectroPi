import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final titleController = TextEditingController();

  final descController = TextEditingController();

  String selectedPriority = "Medium";
  String selectedStatus = "In Progress";

  DateTime? selectedDate;

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime.now(),

      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

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

              const Text("Description (Optional)"),

              const SizedBox(height: 8),

              TextField(
                controller: descController,

                maxLines: 3,

                decoration: InputDecoration(
                  hintText: "Add task description",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Text("Status"),

              const SizedBox(height: 10),

              Row(
                children: [
                  statusChip("Pending", Colors.orange),

                  const SizedBox(width: 8),

                  statusChip("In Progress", Colors.blue),

                  const SizedBox(width: 8),

                  statusChip("Done", Colors.green),
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

              const SizedBox(height: 22),

              const Text("Due Date (Optional)"),

              const SizedBox(height: 10),

              InkWell(
                onTap: pickDate,

                child: Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),

                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined),

                      const SizedBox(width: 10),

                      Text(
                        selectedDate == null
                            ? "Select date"
                            : formatDate(selectedDate!),
                      ),
                    ],
                  ),
                ),
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
                    /// create task

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

  Widget statusChip(String value, Color color) {
    final selected = selectedStatus == value;

    return ChoiceChip(
      label: Text(value, style: TextStyle(color: selected ? Colors.white : Colors.black)),

      selected: selected,

      selectedColor: color,

      checkmarkColor: Colors.white,

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
      label: Text(value, style: TextStyle(color: selected ? Colors.white : Colors.black)),

      selected: selected,

      checkmarkColor: Colors.white,

      selectedColor: color,

      onSelected: (_) {
        setState(() {
          selectedPriority = value;
        });
      },
    );
  }
}
