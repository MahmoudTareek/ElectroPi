// Login Screen with email and password fields, remember me checkbox, forgot password link, social media login buttons, and sign up link.
// import 'package:electropi/layout/news_layout.dart';
import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/layout/layout.dart';
import 'package:electropi/modules/Login_Screen.dart';
import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for email and password input fields
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // Key to manage form state and validation if needed in the future
  var formKey = GlobalKey<FormState>();
  // Variable to toggle password visibility
  bool isPassword = true;
  // Variable to track the state of the "Remember me" checkbox
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushReplacement(
            context,

            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 100.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting texts
                    const Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 150.0),
                      child: Text(
                        'Register to get started',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),

                    // Username input field using a custom defaultFormField widget from components.dart to be used across the app for consistency and reusability
                    defaultFormField(
                      context: context,

                      controller: userNameController,

                      type: TextInputType.name,

                      label: "Full Name",

                      prefix: Icons.person_outline,

                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Enter your name";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    defaultFormField(
                      context: context,

                      controller: emailController,

                      type: TextInputType.emailAddress,

                      label: "Email",

                      prefix: Icons.email_outlined,

                      validate: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }

                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Enter a valid email';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    defaultFormField(
                      context: context,

                      controller: passwordController,

                      type: TextInputType.visiblePassword,

                      label: "Password",

                      prefix: Icons.lock_outline,
                      suffix: isPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixPrssed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      isPassword: isPassword,


                        validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        if (value.length < 8 ||
                            !RegExp(r'[A-Z]').hasMatch(value) ||
                            !RegExp(r'\d').hasMatch(value)) {
                          return 'Password must be at least 8 characters and contain an uppercase letter and a number';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Sign up if the user doesn't have an account
                        Text(
                          'Have an account? ',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              navigateTo(context, LoginScreen());
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    // Sign Up button using a custom defaultButton widget from components.dart for consistency and reusability
                    defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ProjectCubit.get(context).register(
                            username: userNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },

                      text: 'Register',
                      radius: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
