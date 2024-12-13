import 'package:flutter/material.dart';
import 'package:furever_home/view/login_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

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
                  "Create New Account",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF96614D)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: 'WorkSansSemiBold',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(
                      Icons.person_2_outlined,
                      color: Color(0xCC96614D),
                      size: 22.0,
                    ),
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: 'WorkSansSemiBold',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(
                      Icons.call,
                      color: Color(0xCC96614D),
                      size: 22.0,
                    ),
                    labelText: 'Mobile Number',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: 'WorkSansSemiBold',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color(0xCC96614D),
                      size: 22.0,
                    ),
                    labelText: 'Email Address',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle(
                    fontFamily: 'WorkSansSemiBold',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                      color: Color(0xCC96614D),
                      size: 22.0,
                    ),
                    labelText: 'Date of Birth',
                    hintText: 'YYYY-MM-DD',
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  obscureText: true,
                  style: const TextStyle(
                    fontFamily: 'WorkSansSemiBold',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 22.0,
                      color: Color(0xCC96614D),
                    ),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  style: const TextStyle(
                    fontFamily: 'WorkSansSemiBold',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_clock,
                      size: 22.0,
                      color: Color(0xCC96614D),
                    ),
                    labelText: 'Confirm Password',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF66AEA6)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(vertical: 15)),
                    ),
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                    );},
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Already Have An Account? ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors
                          .transparent), // transparent background for outlined button
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30), // Blue border
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
                            builder: (context) => const LoginView()),
                      );
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(
                              0xFF66AEA6)), // Text color matching button border
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
