import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Assuming you have your bloc setup
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  final AuthEntity user; // Accept the user object

  const EditProfileView({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  File? _img; // To store the picked image

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current user data
    _fullNameController = TextEditingController(
        text: '${widget.user.fname} ${widget.user.lname}');
    _phoneNumberController = TextEditingController(text: widget.user.phone);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Function to pick an image (either from gallery or camera)
  Future _browseImage(ImageSource imageSource) async {
    print(imageSource);
    print("$_img, image");
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          print("$image, IMAGE");
          print(_img);
          // Assuming RegisterBloc is where you manage your state for profile updates
          context.read<UserByIdBloc>().add(
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
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Image Section
              GestureDetector(
                onTap: () {
                  // Allow the user to choose between gallery or camera
                  _browseImage(ImageSource
                      .gallery); // Or use ImageSource.camera for camera
                },
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _img == null
                      ? (widget.user.image != null
                          ? NetworkImage(
                              'http://10.0.2.2:5000/uploads/${widget.user.image!}')
                          // 'http://192.168.1.5:5000/uploads/${widget.user.image!}')
                          : const AssetImage('assets/images/profile.png')
                              as ImageProvider)
                      : FileImage(_img!), // Display the picked image
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_fullNameController.text.isNotEmpty &&
                      _phoneNumberController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty) {
                    // Split full name into first name and last name
                    final fullName = _fullNameController.text.split(' ');
                    final firstName = fullName[0];
                    final lastName = fullName.length > 1 ? fullName[1] : '';
                    final registerState = context.read<UserByIdBloc>().state;
                    final imageName = registerState.imageName;

                    // Pass the updated values to the UpdateUserByIdEvent
                    context.read<UserByIdBloc>().add(
                          UpdateUserByIdEvent(
                            id: widget
                                .user.id!, // User ID passed from the widget
                            updatedUser: AuthEntity(
                              fname: firstName,
                              lname: lastName,
                              phone: _phoneNumberController.text,
                              email: _emailController.text,
                              image: imageName ??
                                  widget.user
                                      .image, // Keep the existing image if no new image is selected
                            ),
                          ),
                        );
                  }
                  // Dispatch navigation event after successful update
                  context.read<UserByIdBloc>().add(
                        NavigateToProfilePageEvent(
                          context: context,
                          id: widget.user.id!, // Pass the user id
                        ),
                      );
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
