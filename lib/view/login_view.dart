import 'package:flutter/material.dart';
import 'package:furever_home/view/dashboard_view.dart';
import 'package:furever_home/view/sign_up_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email == 'admin' && password == 'admin') {
      // Navigate to DashboardView
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const DashboardView(),
        ),
      );
    } else {
      // Show an error dialog or snackbar
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Credentials"),
          content: const Text("Please enter valid email and password."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF96614D)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF96614D),
                  ),
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10)),
                    // focusedBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10)),
                    // border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xCC96614D),
                      size: 22.0,
                    ),
                    labelText: 'Email Address',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF96614D),
                  ),
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10)),
                    // focusedBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 22.0,
                      color: Color(0xCC96614D),
                    ),
                    labelText: 'Password',
                  ),
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
                    // style: ButtonStyle(
                    //   backgroundColor: WidgetStateProperty.all<Color>(
                    //       const Color(0xFF66AEA6)),
                    //   shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    //     RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30),
                    //     ),
                    //   ),
                    //   padding: WidgetStateProperty.all<EdgeInsets>(
                    //       const EdgeInsets.symmetric(vertical: 15)),
                    // ),
                    onPressed: _handleLogin,
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
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpView()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: Color(0xFF66AEA6)),
                    ),
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
