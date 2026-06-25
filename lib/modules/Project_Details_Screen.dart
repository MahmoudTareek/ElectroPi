import 'package:flutter/material.dart';

class ProjectDetailsScreen extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Project Details'),
       ),
       body: Center(
         child: Text('Details of the selected project will be displayed here.'),
       ),
     );
   }
 }