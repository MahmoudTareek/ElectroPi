import 'package:electropi/cubit/states.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/shared/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProjectCubit.get(context);
    String? userName = CacheHelper.getString(key: 'username');
    String? email = CacheHelper.getString(key: 'email');
    TextEditingController userNameController = TextEditingController(
      text: userName,
    );
    TextEditingController emailController = TextEditingController(text: email);
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {
        Fluttertoast.showToast(
          msg: 'Profile Updated',
          backgroundColor: Colors.green,
        );
      },
      builder: (context, state) => Scaffold(
        backgroundColor: const Color(0xffF7F9FC),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        userName ?? "Guest",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        email ?? "",
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            defaultFormField(
                              context: context,
                              controller: userNameController,
                              type: TextInputType.name,
                              label: "User Name",
                              prefix: Icons.person_outline,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your name";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            defaultFormField(
                              context: context,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: "Email",
                              prefix: Icons.email_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter email";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () {
                            cubit.updateProfile(
                              username: userNameController.text,
                              email: emailController.text,
                            );
                          },
                          child: Text(
                            "Update Profile",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () async {
                            cubit.currentIndex = 0;
                            await CacheHelper.removeData(key: 'token');
                            userNameController.clear();
                            emailController.clear();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login',
                              (route) => false,
                            );
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
