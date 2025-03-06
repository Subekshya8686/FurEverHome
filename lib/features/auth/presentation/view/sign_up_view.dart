import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/app/di/di.dart';
import 'package:furever_home/core/common/snackbar/my_snackbar.dart';
import 'package:furever_home/features/auth/presentation/view/sign_in_view.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furever_home/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: '');
  final _lnameController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');

  final _emailController = TextEditingController(text: '');

  // final _dateOfBirthController = TextEditingController(text: '2025-01-01');

  // final _usernameController = TextEditingController(text: 'subekshya');
  final _passwordController = TextEditingController(text: '');

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;

  Future _browseImage(ImageSource imageSource) async {
    print(imageSource);
    print("$_img,image");
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          print("$image, IMAGE");
          print(_img);
          context.read<RegisterBloc>().add(
                LoadImage(file: _img!),
              );
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  const Text(
                    "Create New Account",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF96614D)),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[300],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  checkCameraPermission();
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                  // Upload image it is not null
                                },
                                // icon: const Icon(Icons.camera),
                                // label: const Text('Camera'),
                                icon: const Icon(Icons.camera,
                                    size: 24, color: Colors.white),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFB34A2E),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // Rounded corners
                                  ),
                                ),
                                label: const Text('Camera',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.bold)), // Text styling
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                // icon: const Icon(Icons.image),
                                // label: const Text('Gallery'),
                                icon: const Icon(Icons.image,
                                    size: 24, color: Colors.white),
                                label: const Text('Gallery',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF66AEA6),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // Rounded corners
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 150,
                      width: 200,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _img != null
                            ? FileImage(_img!)
                            : const AssetImage(
                                    'assets/images/add_image_icon.png')
                                as ImageProvider,
                        // backgroundImage:
                        //     const AssetImage('assets/images/profile.png')
                        //         as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _fnameController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: 'WorkSansSemiBold',
                      fontSize: 16.0,
                      color: Color(0xFF96614D),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person_2_outlined,
                        color: Color(0xCC96614D),
                        size: 22.0,
                      ),
                      labelText: 'First Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _lnameController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: 'WorkSansSemiBold',
                      fontSize: 16.0,
                      color: Color(0xFF96614D),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person_2_outlined,
                        color: Color(0xCC96614D),
                        size: 22.0,
                      ),
                      labelText: 'Last Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: 'WorkSansSemiBold',
                      fontSize: 16.0,
                      color: Color(0xFF96614D),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.call,
                        color: Color(0xCC96614D),
                        size: 22.0,
                      ),
                      labelText: 'Mobile Number',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phoneNo';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: 'WorkSansSemiBold',
                      fontSize: 16.0,
                      color: Color(0xFF96614D),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color(0xCC96614D),
                        size: 22.0,
                      ),
                      labelText: 'Email',
                      // hintText: 'YYYY-MM-DD',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(
                      fontFamily: 'WorkSansSemiBold',
                      fontSize: 16.0,
                      color: Color(0xFF96614D),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
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
                  // const SizedBox(height: 20),
                  // TextFormField(
                  //   obscureText: true,
                  //   style: const TextStyle(
                  //     fontFamily: 'WorkSansSemiBold',
                  //     fontSize: 16.0,
                  //     color: Colors.black,
                  //   ),
                  //   decoration: InputDecoration(
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     prefixIcon: const Icon(
                  //       Icons.lock_clock,
                  //       size: 22.0,
                  //       color: Color(0xCC96614D),
                  //     ),
                  //     labelText: 'Confirm Password',
                  //   ),
                  // ),
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
                      // onPressed: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => LoginView()),
                      //   );
                      // },
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          final registerState =
                              context.read<RegisterBloc>().state;
                          final imageName = registerState.imageName;
                          context.read<RegisterBloc>().add(
                                RegisterStudent(
                                  fname: _fnameController.text,
                                  lname: _lnameController.text,
                                  phone: _phoneController.text,
                                  // email: _emailController.text,
                                  // dateOfBirth: _dateOfBirthController.text,
                                  password: _passwordController.text,
                                  email: _emailController.text,
                                  image: imageName,
                                  context: context,
                                ),
                              );
                          // NavigateToHomeScreenEvent(
                          //   context: context,
                          //   destination: LoginView(),
                          // );
                        } else {
                          showMySnackBar(
                            context: context,
                            message: 'Could not Register',
                            color: Colors.red,
                          );
                        }
                      },
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
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.transparent),
                        // transparent background for outlined button
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
                          // MaterialPageRoute(builder: (context) => LoginView()),
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: getIt<LoginBloc>(),
                              child: LoginView(),
                            ),
                          ),
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
      ),
    );
  }
}
