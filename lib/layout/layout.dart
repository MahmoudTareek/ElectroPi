import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';

class ProjectLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProjectCubit.get(context);
        return Scaffold(
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              // Change the current index and update the UI
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
            selectedItemColor: primaryColor,
            unselectedItemColor: secondaryColor,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}