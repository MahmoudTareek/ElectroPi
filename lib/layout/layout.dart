// Layout for the news app using Bloc pattern and BottomNavigationBar for navigation between different screens of the app.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProjectCubit.get(context);
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('News App'),
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.only(right: 8.0),
          //       child: IconButton(
          //         icon: Icon(Icons.notifications_outlined),
          //         onPressed: () {},
          //       ),
          //     ),
          //   ],
          // ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              // Change the current index and update the UI
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}