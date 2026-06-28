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
    final size = MediaQuery.of(context).size;

    final width = size.width;

    final height = size.height;

    return BlocBuilder<ProjectCubit, ProjectStates>(
      builder: (context, state) {
        final cubit = ProjectCubit.get(context);

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          floatingActionButton: SizedBox(
            width: width < 360 ? 52 : 58,

            height: width < 360 ? 52 : 58,

            child: FloatingActionButton(
              backgroundColor: primaryColor,

              foregroundColor: Colors.white,

              onPressed: () {
                showModalBottomSheet(
                  context: context,

                  isScrollControlled: true,

                  useSafeArea: true,

                  backgroundColor: Colors.transparent,

                  builder: (_) => const AddTaskBottomSheet(),
                );
              },

              child: Icon(Icons.add, size: width < 360 ? 24 : 28),
            ),
          ),

          body: SafeArea(
            bottom: false,

            child: Column(
              children: [
                Container(
                  color: primaryColor,

                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .05,

                      vertical: height * .02,
                    ),

                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: Icon(
                            Icons.arrow_back_ios,

                            color: Colors.white,

                            size: width < 360 ? 20 : 24,
                          ),
                        ),

                        Expanded(
                          child: Text(
                            project.title,

                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: Colors.white,

                              fontSize: width < 360 ? 18 : 22,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(width: width < 360 ? 32 : 40),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: state is GetTasksLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          padding: EdgeInsets.all(width * .05),

                          children: [
                            Text(
                              'Tasks (${cubit.projectTasks.length})',

                              style: TextStyle(
                                fontSize: width < 360 ? 22 : 24,

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: height * .025),

                            ...cubit.projectTasks.map(
                              (task) => Padding(
                                padding: EdgeInsets.only(bottom: height * .018),

                                child: TaskCard(
                                  task: task,

                                  onTap: () {
                                    cubit.toggleTask(
                                      cubit.projectTasks.indexOf(task),
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
          ),
        );
      },
    );
  }
}