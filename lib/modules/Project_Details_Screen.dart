import 'package:electropi/modules/Add_Task_Bottom_Sheet.dart';
import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final String? projectTitle;
  const ProjectDetailsScreen({super.key, this.projectTitle});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  // int currentIndex = 1;

  final List<TaskModel> tasks = [
    TaskModel(title: "Create wireframes", priority: "High", status: "Done"),
    TaskModel(
      title: "Design home page",
      priority: "High",
      status: "In Progress",
    ),
    TaskModel(
      title: "Implement responsive UI",
      priority: "Medium",
      status: "Pending",
    ),
    TaskModel(title: "Integrate CMS", priority: "Low", status: "Pending"),
    TaskModel(
      title: "Design home page",
      priority: "High",
      status: "In Progress",
    ),
    TaskModel(
      title: "Implement responsive UI",
      priority: "Medium",
      status: "Pending",
    ),
  ];

  bool get hasSelected => tasks.any((e) => e.isSelected);

  void toggleTask(int index) {
    setState(() {
      tasks[index].isSelected = !tasks[index].isSelected;
    });
  }

  void markAsDone() {
    setState(() {
      for (var task in tasks) {
        if (task.isSelected) {
          task.status = "Done";

          task.isSelected = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          foregroundColor: secondaryColor,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const AddTaskBottomSheet(),
            );
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            /// HEADER
            Container(
              color: primaryColor,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text(
                              widget.projectTitle ?? "Project Details",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const TabBar(
                    indicatorColor: primaryColor,
                    indicatorWeight: 3,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    tabs: [
                      Tab(text: "Tasks"),
                      Tab(text: "Details"),
                      Tab(text: "Activity"),
                    ],
                  ),
                ],
              ),
            ),

            /// BODY
            Expanded(
              child: TabBarView(
                children: [
                  /// TASKS TAB
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(
                              "Tasks (${tasks.length})",

                              style: const TextStyle(
                                fontSize: 22,

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            if (hasSelected)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),

                                onPressed: markAsDone,

                                child: const Text(
                                  "Done",

                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: tasks.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 18),
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: tasks[index],

                              onTap: () {
                                toggleTask(index);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const Center(child: Text("Details Screen")),

                  const Center(child: Text("Activity Screen")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
