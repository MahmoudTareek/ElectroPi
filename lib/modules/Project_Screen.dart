import 'package:flutter/material.dart';

import '../shared/components.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff2563FF),
        elevation: 6,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),

      body: Column(
        children: [

          /// HEADER
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              left: 24,
              right: 24,
            ),
            decoration: const BoxDecoration(
              color: Color(0xff001B66),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Row(
                //   mainAxisAlignment:
                //       MainAxisAlignment.spaceBetween,
                //   children: const [
                //     Icon(
                //       Icons.menu,
                //       color: Colors.white,
                //     ),
                //     Icon(
                //       Icons.notifications_none,
                //       color: Colors.white,
                //     ),
                //   ],
                // ),

                // const SizedBox(height: 20),

                const Text(
                  "My Projects",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Here are your projects",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon:
                          const Icon(Icons.search),
                      suffixIcon:
                          const Icon(Icons.tune),
                      hintText:
                          "Search projects...",
                      contentPadding:
                          const EdgeInsets.only(
                        top: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [

                ProjectCard(
                  title: "Website Redesign",
                  subtitle:
                      "Redesign marketing website",
                  status: "Active",
                  icon: Icons.web,
                  iconColor: Colors.blue,
                ),

                SizedBox(height: 18),

                ProjectCard(
                  title: "Mobile App",
                  subtitle:
                      "Build cross platform app",
                  status: "In Progress",
                  icon: Icons.phone_android,
                  iconColor: Colors.deepPurple,
                ),

                SizedBox(height: 18),

                ProjectCard(
                  title: "API Integration",
                  subtitle:
                      "Integrate payment gateway",
                  status: "Pending",
                  icon: Icons.api,
                  iconColor: Colors.amber,
                ),

                SizedBox(height: 18),

                ProjectCard(
                  title: "Dashboard",
                  subtitle:
                      "Admin dashboard development",
                  status: "Active",
                  icon: Icons.dashboard,
                  iconColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

