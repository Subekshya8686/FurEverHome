import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/app/di/di.dart';
import 'package:furever_home/features/auth/domain/use_case/get_user_by_id_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/update_user_by_id_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:furever_home/features/profile/presentation/view/edit_profile_view.dart';
import 'package:furever_home/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final UserByIdBloc _userByIdBloc;

  @override
  void initState() {
    super.initState();
    _userByIdBloc = UserByIdBloc(
      getUserByIdUseCase: getIt<GetUserByIdUseCase>(),
      updateUserByIdUseCase: getIt<UpdateStudentByIdUseCase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
    );
    _loadUserIdAndFetchData();
  }

  Future<void> _loadUserIdAndFetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId =
        prefs.getString('userId'); // Get the user ID from shared preferences.

    if (userId != null) {
      _userByIdBloc.add(GetUserByIdEvent(userId)); // Fetch user data by ID.
    } else {
      print("User ID not found in SharedPreferences.");
    }
  }

  @override
  void dispose() {
    _userByIdBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _userByIdBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "User Profile",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF96614D),
            ),
          ),
          backgroundColor: Colors.grey[200],
          elevation: 0.0,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Ensure the user data is not null before navigating to the edit page
                final user = _userByIdBloc
                    .state.user; // Access the user from the bloc's state
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: getIt<UserByIdBloc>(),
                        child: EditProfileView(user: user),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<UserByIdBloc, UserByIdState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage != null) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else if (state.user != null) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image
                      InkWell(
                        onTap: () {
                          // Optional: Add functionality to update the profile image
                        },
                        child: Center(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xFF96614D), width: 3),
                            ),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: state.user!.image != null
                                  ? NetworkImage(
                                      // 'http://10.0.2.2:5000/uploads/${state.user!.image!}')
                                      'http://192.168.1.5:5000/uploads/${state.user!.image!}')
                                  : const AssetImage(
                                          'assets/images/profile.png')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // User Details Section without the labels
                      _buildUserDetailTile(Icons.person_2_outlined,
                          '${state.user!.fname} ${state.user!.lname}'),
                      _buildUserDetailTile(
                          Icons.call, state.user!.phone ?? 'Not available'),
                      _buildUserDetailTile(
                          Icons.email, state.user!.email ?? 'Not available'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No user found'));
            }
          },
        ),
      ),
    );
  }

  // Helper method to build ListTile for each user detail
  Widget _buildUserDetailTile(IconData icon, String subtitle) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: const Color(0xCC96614D)),
          title: Text(subtitle),
        ),
        const Divider(thickness: 1, color: Colors.grey),
      ],
    );
  }
}
