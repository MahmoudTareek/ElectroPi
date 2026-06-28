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
@override
Widget build(BuildContext context) {
  return BlocBuilder<ProjectCubit, ProjectStates>(
    builder: (context, state) {
      var cubit = ProjectCubit.get(context);
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
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
                          child: Text(
                            project.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: state is GetTasksLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tasks (${cubit.projectTasks.length})',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ...cubit.projectTasks.map(
                          (task) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: 14),

                            child: TaskCard(
                              task: task,

                              onTap: () {
                                cubit.toggleTask(
                                  cubit.projectTasks.indexOf(
                                    task,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      );
    },
  );
}
}
