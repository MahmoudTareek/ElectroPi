// Profile Screen with user information and logout functionality, update info feature.
// It was in the Figma design, I added some features as update button to show a friendly message to user, logout button to return back to onboarding screen.
import 'package:electropi/modules/Login_Screen.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:electropi/cubit/cubit.dart';
// import 'package:electropi/modules/onBoarding/on_boarding_screen.dart';
import 'package:electropi/shared/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for user input fields
    var cubit = ProjectCubit.get(context);
    String? userName = CacheHelper.getString(key: 'username');

    String? email = CacheHelper.getString(key: 'email');

    TextEditingController userNameController = TextEditingController(
      text: userName,
    );

    TextEditingController emailController = TextEditingController(text: email);
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile image for user
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: // AssetImage('assets/images/profile_image.png'),
                          NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                      ) as ImageProvider<Object>?,
                    ),
                  ),
                  SizedBox(height: 30),
                  // User name input field
                  defaultFormField(
                    context: context,
                    controller: userNameController,
                    type: TextInputType.text,
                    // validation for user name
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    label: 'User Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 20),
                  // Email input field
                  defaultFormField(
                    context: context,
                    controller: emailController,
                    type: TextInputType.text,
                    // validation for email
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                        r'^[^@]+@[^@]+\.[^@]+',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email,
                  ),
                  SizedBox(height: 30),
                  // Row with Update and Logout buttons
                  Row(
                    children: [
                      Expanded(
                        child: defaultButton(
                          function: () {
                            // Show a toast message on successful update
                            Fluttertoast.showToast(
                              msg: "Your Information Updated Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          text: 'Update',
                          background: Colors.blue,
                          radius: 50.0,
                        ),
                      ),
                      SizedBox(width: 10),
                      // Logout button to navigate back to onboarding screen
                      Expanded(
                        child: defaultButton(
                          function: () async {
                            // Reset the bottom navigation index to 0 (home) on logout to open on it after login again, and navigate to onboarding screen
                            cubit.currentIndex = 0;
                            // navigateTo is a custom function defined in components.dart to navigate to a new screen to be easier to use everywhere in the app without repeating the same code again and again
                            // navigateTo(context, LoginScreen());
                            await CacheHelper.removeData(key: 'token');
                            userNameController.clear();
                            emailController.clear();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false,
                            );
                          },
                          text: 'Logout',
                          background: Colors.red,
                          radius: 50.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
