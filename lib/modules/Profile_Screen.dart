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
    final cubit = ProjectCubit.get(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    String? userName = CacheHelper.getString(key: 'username');

    String? email = CacheHelper.getString(key: 'email');

    final userNameController = TextEditingController(text: userName);

    final emailController = TextEditingController(text: email);

    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {
        Fluttertoast.showToast(
          msg: 'Profile Updated',

          backgroundColor: Colors.green,
        );
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height * .32,

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
                          padding: EdgeInsets.all(width < 360 ? 3 : 5),

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            color: isDark
                                ? const Color(0xff2A2A2A)
                                : Colors.white,
                          ),

                          child: CircleAvatar(
                            radius: width * .14,

                            backgroundImage: const NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                            ),
                          ),
                        ),

                        SizedBox(height: height * .02),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * .08,
                          ),

                          child: Text(
                            userName ?? "Guest",

                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,

                            style: TextStyle(
                              color: Colors.white,

                              fontSize: width < 360 ? 20 : 22,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * .08,
                          ),

                          child: Text(
                            email ?? "",

                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,

                            style: TextStyle(
                              color: Colors.white70,

                              fontSize: width < 360 ? 13 : 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(width * .06),

                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(width * .05),

                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xff1E1E1E)
                                : Colors.white,

                            borderRadius: BorderRadius.circular(25),

                            boxShadow: [
                              BoxShadow(
                                color: isDark ? Colors.black26 : Colors.black12,

                                blurRadius: 15,

                                offset: const Offset(0, 6),
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

                              const SizedBox(height: 20),

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

                        SizedBox(height: height * .04),

                        SizedBox(
                          width: double.infinity,

                          height: width < 360 ? 52 : 58,

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
                                fontSize: width < 360 ? 16 : 18,

                                fontWeight: FontWeight.w600,

                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,

                          height: width < 360 ? 52 : 58,

                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),

                            onPressed: () async {
                              cubit.currentIndex = 0;

                              await CacheHelper.removeData(key: 'token');

                              await CacheHelper.removeData(key: 'username');

                              await CacheHelper.removeData(key: 'email');

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

                                fontSize: width < 360 ? 16 : 18,

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
        );
      },
    );
  }
}