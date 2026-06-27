import 'package:electropi/models/projects_model.dart';
import 'package:electropi/modules/Empty_Projects_Screen.dart';
import 'package:flutter/material.dart';

import '../shared/components.dart';

class ProjectsScreen extends StatelessWidget {
  ProjectsScreen({super.key});

  Future<void> refreshProjects() async {
    await Future.delayed(const Duration(seconds: 2));

    /// API Call Later
    /// await ProjectsCubit.get(context).getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// HEADER
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24),

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
                const Text(
                  "My Projects",

                  style: TextStyle(
                    color: secondaryColor,

                    fontSize: 30,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Here are your projects",

                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 25),

                Container(
                  height: 55,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      prefixIcon: Icon(Icons.search),

                      suffixIcon: Icon(Icons.tune),

                      hintText: "Search projects...",

                      contentPadding: EdgeInsets.only(top: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// CONTENT
          Expanded(
            child: RefreshIndicator(
              color: const Color(0xff2563FF),

              onRefresh: refreshProjects,

              child: projects.isEmpty
                  /// EMPTY
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),

                      children: const [
                        SizedBox(height: 80),

                        EmptyProjectsWidget(),
                      ],
                    )
                  /// PROJECTS
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),

                      padding: const EdgeInsets.all(20),

                      itemCount: projects.length,

                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),

                          child: projects[index],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
