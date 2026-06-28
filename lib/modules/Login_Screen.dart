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
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isPassword = true;

  String? emailError;

  String? passwordError;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          setState(() {
            emailError = null;

            passwordError = null;
          });

          Navigator.pushNamedAndRemoveUntil(
            context,

            '/layout',

            (route) => false,
          );
        }

        if (state is LoginErrorState) {
          setState(() {
            if (state.error == 'Email not found') {
              emailError = state.error;

              passwordError = null;
            } else if (state.error == 'Incorrect password') {
              passwordError = state.error;

              emailError = null;
            }
          });

          formKey.currentState!.validate();
        }
      },

      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,

          backgroundColor: isDark ? const Color(0xff121212) : Colors.white,

          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: height - MediaQuery.of(context).padding.top,
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .06,
                  ).copyWith(top: height * .08, bottom: 30),

                  child: Form(
                    key: formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Hello',

                          style: TextStyle(
                            fontSize: width < 360 ? 34 : 40,

                            fontWeight: FontWeight.bold,

                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),

                        Text(
                          'Again!',

                          style: TextStyle(
                            fontSize: width < 360 ? 34 : 40,

                            fontWeight: FontWeight.bold,

                            color: primaryColor,
                          ),
                        ),

                        SizedBox(height: height * .015),

                        SizedBox(
                          width: width * .7,

                          child: Text(
                            'Login to continue to your account',

                            style: TextStyle(
                              fontSize: width < 360 ? 16 : 18,

                              color: isDark ? Colors.white70 : Colors.grey[600],
                            ),
                          ),
                        ),

                        SizedBox(height: height * .06),

                        defaultFormField(
                          context: context,

                          controller: emailController,

                          type: TextInputType.emailAddress,

                          onChange: (_) {
                            if (emailError != null) {
                              setState(() {
                                emailError = null;
                              });
                            }
                          },

                          label: 'Email',

                          prefix: Icons.email_outlined,

                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }

                            if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }

                            return emailError;
                          },
                        ),

                        const SizedBox(height: 20),

                        defaultFormField(
                          context: context,

                          controller: passwordController,

                          type: TextInputType.visiblePassword,

                          onChange: (_) {
                            if (passwordError != null) {
                              setState(() {
                                passwordError = null;
                              });
                            }
                          },

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

                            return passwordError;
                          },
                        ),

                        SizedBox(height: height * .06),

                        state is LoginLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : defaultButton(
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

                        SizedBox(height: height * .015),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Flexible(
                              child: Text(
                                'Don’t have an account?',

                                style: TextStyle(
                                  fontSize: width < 360 ? 13 : 14,

                                  color: isDark ? Colors.white70 : Colors.black,
                                ),
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },

                              child: const Text(
                                'Register',

                                style: TextStyle(
                                  color: primaryColor,

                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: height * .04),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
