import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/layout',
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
                        Text(
                          'Don’t have an account? ',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
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
