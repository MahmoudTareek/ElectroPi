import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';


final List<Widget> projects = [
    ProjectCard(
      title: "Website Redesign",
      subtitle: "Redesign marketing website",
      status: "Active",
      icon: Icons.web,
      iconColor: Colors.blue,
    ),

    ProjectCard(
      title: "Mobile App",
      subtitle: "Build cross platform app",
      status: "In Progress",
      icon: Icons.phone_android,
      iconColor: Colors.deepPurple,
    ),

    ProjectCard(
      title: "API Integration",
      subtitle: "Integrate payment gateway",
      status: "Pending",
      icon: Icons.api,
      iconColor: Colors.amber,
    ),

    ProjectCard(
      title: "Dashboard",
      subtitle: "Admin dashboard development",
      status: "Active",
      icon: Icons.dashboard,
      iconColor: Colors.green,
    ),

    // جرب الـ Empty State:
    // سيب الليست فاضية []
  ];