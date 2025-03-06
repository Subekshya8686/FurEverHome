import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/auth/presentation/view/sign_up_view.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF96614D),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: const ValueKey('email'),
                      controller: _emailController,
                      // keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF96614D),
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xCC96614D),
                          size: 22.0,
                        ),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF96614D),
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 22.0,
                          color: Color(0xCC96614D),
                        ),
                        labelText: 'Password',
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      }),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/forget-password");
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // onPressed: _handleLogin,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                                  LoginStudentEvent(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Don't Have An Account? ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        key: const ValueKey("registerButton"),
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(vertical: 15),
                          ),
                          side: WidgetStateProperty.all<BorderSide>(
                            const BorderSide(
                              // color: Color(0xCC7A4F3A), // Custom border color
                              color: Color(0xFF66AEA6), // Custom border color
                              width: 1.0, // Adjust the width as needed
                            ),
                          ),
                        ),
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                NavigateRegisterScreenEvent(
                                  destination: SignUpView(),
                                  context: context,
                                ),
                              );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const SignUpView()),
                          // );
                        },
                        child: const Text(
                          "Sign Up",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF66AEA6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
