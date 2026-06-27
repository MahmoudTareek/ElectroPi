// Login Screen with email and password fields, remember me checkbox, forgot password link, social media login buttons, and sign up link.
// import 'package:electropi/layout/news_layout.dart';
import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/layout/layout.dart';
import 'package:electropi/modules/Registration_Screen.dart';
import 'package:electropi/shared/components.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for email and password input fields
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
        if (state is LoginSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,

            MaterialPageRoute(builder: (_) => NewsLayout()),

            (route) => false,
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
                      'Hello',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Again!',
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
                        'Login to continue to your account',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),

                    // Email input field using a custom defaultFormField widget from components.dart to be used across the app for consistency and reusability
                    defaultFormField(
                      context: context,

                      controller: emailController,

                      type: TextInputType.emailAddress,

                      label: 'Email',

                      prefix: Icons.email_outlined,

                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }

                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    defaultFormField(
                      context: context,

                      controller: passwordController,

                      type: TextInputType.visiblePassword,

                      label: 'Password',

                      prefix: Icons.lock_outline,

                      isPassword: isPassword,

                      suffix: isPassword
                          ? Icons.visibility
                          : Icons.visibility_off,

                      suffixPrssed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },

                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password must not be empty';
                        }

                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 50.0),
                    // Login button using a custom defaultButton widget from components.dart for consistency and reusability
                    defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ProjectCubit.get(context).login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },

                      text: 'Login',
                      radius: 10,
                    ),

                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Sign up if the user doesn't have an account
                        Text(
                          'Don’t have an account? ',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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
