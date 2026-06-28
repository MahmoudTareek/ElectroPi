import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/models/projects_model.dart';
import 'package:electropi/modules/Add_Task_Bottom_Sheet.dart';
import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({super.key, required this.project});

  bool hasSelected(ProjectCubit cubit) {
    return cubit.projectTasks.any((e) => e.selected);
  }
  void markAsDone(ProjectCubit cubit) {
    for (var task in cubit.projectTasks) {
      if (task.selected) {
        task.status = 'Done';
        task.selected = false;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<ProjectCubit, ProjectStates>(
        builder: (context, state) {
          var cubit = ProjectCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
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
            body: Column(
              children: [
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
                                  project.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                      ),
                      const TabBar(
                        indicatorColor: Colors.white,
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
                Expanded(
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tasks (${cubit.projectTasks.length})',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (state is GetTasksLoading)
                            const Expanded(
                              child: Center(child: CircularProgressIndicator()),
                            )
                          else
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                itemCount: cubit.projectTasks.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  return TaskCard(
                                    task: cubit.projectTasks[index],
                                    onTap: () {
                                      cubit.toggleTask(index);
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(project.description),
                            const SizedBox(height: 30),
                            const Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(project.status),
                            ),
                          ],
                        ),
                      ),
                      const Center(child: Text('No Activity Yet')),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
