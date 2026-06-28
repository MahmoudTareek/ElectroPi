import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isPassword = true;

  String? emailError;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushReplacementNamed(context, '/login');
        }

        if (state is RegisterErrorState) {
          setState(() {
            emailError = state.error;
          });
        }

        if (state is RegisterSuccessState) {
          setState(() {
            emailError = null;
          });

          Navigator.pushReplacementNamed(context, '/login');
        }

        if (state is RegisterErrorState) {
          setState(() {
            emailError = state.error;
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
                          'Create',

                          style: TextStyle(
                            fontSize: width < 360 ? 34 : 40,

                            fontWeight: FontWeight.bold,

                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),

                        Text(
                          'Account',

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
                            'Register to get started',

                            style: TextStyle(
                              fontSize: width < 360 ? 16 : 18,

                              color: isDark ? Colors.white70 : Colors.grey[600],
                            ),
                          ),
                        ),

                        SizedBox(height: height * .06),

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

                        const SizedBox(height: 20),

                        defaultFormField(
                          context: context,

                          controller: emailController,

                          type: TextInputType.emailAddress,

                          label: 'Email',

                          prefix: Icons.email_outlined,

                          onChange: (value) {
                            if (emailError != null) {
                              setState(() {
                                emailError = null;
                              });
                            }
                          },

                          validate: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }

                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Enter a valid email';
                            }

                            return emailError;
                          },
                        ),

                        const SizedBox(height: 20),

                        defaultFormField(
                          context: context,

                          controller: passwordController,

                          type: TextInputType.visiblePassword,

                          label: "Password",

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
                              return 'Password is required';
                            }

                            if (value.length < 8 ||
                                !RegExp(r'[A-Z]').hasMatch(value) ||
                                !RegExp(r'\d').hasMatch(value)) {
                              return 'Password must contain uppercase and number';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: height * .02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Flexible(
                              child: Text(
                                'Have an account?',

                                style: TextStyle(
                                  fontSize: width < 360 ? 13 : 14,

                                  color: isDark ? Colors.white70 : Colors.black,
                                ),
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },

                              child: const Text(
                                'Sign In',

                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: height * .02),

                        state is RegisterLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : defaultButton(
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

                                radius: 12,
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
