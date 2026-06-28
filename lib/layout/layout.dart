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

        final width = MediaQuery.of(context).size.width;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          body: SafeArea(child: cubit.screen[cubit.currentIndex]),

          bottomNavigationBar: SafeArea(
            child: BottomNavigationBar(
              currentIndex: cubit.currentIndex,

              onTap: cubit.changeBottomNavBar,

              items: cubit.bottomItems,

              type: BottomNavigationBarType.fixed,

              selectedItemColor: primaryColor,

              unselectedItemColor: isDark ? Colors.white54 : secondaryColor,

              backgroundColor: isDark ? const Color(0xff1E1E1E) : Colors.white,

              elevation: 12,

              selectedFontSize: width < 360 ? 10 : 12,

              unselectedFontSize: width < 360 ? 9 : 11,

              iconSize: width < 360 ? 22 : 26,
            ),
          ),
        );
      },
    );
  }
}
