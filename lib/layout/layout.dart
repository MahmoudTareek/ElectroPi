import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';

class ProjectLayout extends StatelessWidget {
  const ProjectLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {},

      builder: (context, state) {
        var cubit = ProjectCubit.get(context);

        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          body: cubit.screen[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,

            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },

            items: cubit.bottomItems,

            type: BottomNavigationBarType.fixed,

            selectedItemColor: primaryColor,

            unselectedItemColor: isDark ? Colors.white54 : secondaryColor,

            backgroundColor: isDark ? const Color(0xff1E1E1E) : Colors.white,

            elevation: 12,
          ),
        );
      },
    );
  }
}
