import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/modules/Empty_Projects_Screen.dart';
import 'package:electropi/modules/Project_Details_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ProjectCubit.get(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {
        if (state is SearchProjectErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }

        if (state is GetProjectsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },

      builder: (context, state) {
        if (state is GetProjectsError) {
          return Center(child: Text(state.error));
        }
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          body: SafeArea(
            bottom: false,

            child: Column(
              children: [
                Container(
                  height: height * .25,

                  width: double.infinity,

                  padding: EdgeInsets.symmetric(
                    horizontal: width * .06,
                  ).copyWith(top: height * .02),

                  decoration: const BoxDecoration(
                    color: primaryColor,

                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),

                      bottomRight: Radius.circular(30),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            "My Projects",

                            style: TextStyle(
                              color: Colors.white,

                              fontSize: width < 360 ? 26 : 30,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              cubit.changeTheme();
                            },

                            icon: Icon(
                              cubit.isDark ? Icons.light_mode : Icons.dark_mode,

                              color: Colors.white,

                              size: width < 360 ? 22 : 26,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * .01),

                      Text(
                        "Here are your projects",

                        style: TextStyle(
                          color: Colors.white70,

                          fontSize: width < 360 ? 14 : 16,
                        ),
                      ),

                      SizedBox(height: height * .03),

                      Container(
                        height: width < 360 ? 50 : 55,

                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xff1E1E1E)
                              : Colors.white,

                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: TextField(
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),

                          onChanged: (value) {
                            cubit.searchProjects(value);
                          },

                          decoration: InputDecoration(
                            border: InputBorder.none,

                            prefixIcon: Icon(
                              Icons.search,

                              color: isDark ? Colors.white70 : Colors.grey,
                            ),

                            suffixIcon: Icon(
                              Icons.tune,

                              color: isDark ? Colors.white70 : Colors.grey,
                            ),

                            hintText: "Search for a project...",

                            hintStyle: TextStyle(
                              color: isDark ? Colors.white54 : Colors.grey,
                            ),

                            contentPadding: EdgeInsets.symmetric(
                              vertical: width < 360 ? 12 : 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: state is GetProjectsLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : RefreshIndicator(
                          color: primaryColor,

                          onRefresh: () async {
                            await cubit.getProjects();
                          },

                          child: cubit.filteredProjects.isEmpty
                              ? ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),

                                  children: [
                                    SizedBox(height: height * .08),

                                    const EmptyProjectsWidget(),
                                  ],
                                )
                              : ListView.separated(
                                  padding: EdgeInsets.only(
                                    top: height * .015,

                                    bottom: 20,
                                  ),

                                  itemCount: cubit.filteredProjects.length,

                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: height * .012),

                                  itemBuilder: (context, index) {
                                    final model = cubit.filteredProjects[index];

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * .03,
                                      ),

                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(18),

                                        onTap: () async {
                                          await cubit.getProjectTasks(
                                            model.userId,
                                          );

                                          Navigator.push(
                                            context,

                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ProjectDetailsScreen(
                                                    project: model,
                                                  ),
                                            ),
                                          );
                                        },

                                        child: ProjectCard(
                                          project: model,

                                          icon: Icons.folder,

                                          iconColor: primaryColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
