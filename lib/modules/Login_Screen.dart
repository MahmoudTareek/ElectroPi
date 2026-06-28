import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          backgroundColor: isDark ? const Color(0xff121212) : Colors.white,

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),

              child: Form(
                key: formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    /// TITLE
                    Text(
                      'Hello',

                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,

                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),

                    const Text(
                      'Again!',

                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(right: 150),

                      child: Text(
                        'Login to continue to your account',

                        style: TextStyle(
                          fontSize: 18,

                          color: isDark ? Colors.white70 : Colors.grey[600],
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    /// EMAIL
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

                    const SizedBox(height: 20),

                    /// PASSWORD
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

                    const SizedBox(height: 50),

                    /// LOGIN BUTTON
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

                      radius: 12,
                    ),

                    const SizedBox(height: 10),

                    /// REGISTER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          'Don’t have an account? ',

                          style: TextStyle(
                            fontSize: 14,

                            color: isDark ? Colors.white70 : Colors.black,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },

                          child: const Text(
                            'Register',

                            style: TextStyle(color: primaryColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
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
