import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/core/common/snackbar/my_snackbar.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:furever_home/features/home/presentation/view_model/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: const Text('Home'),
        title: Row(
          children: [
            // Add your image here
            Image.asset(
              'assets/images/fureverHome_logo.png', // Path to your image asset
              width: 60, // Adjust the width as needed
              height: 45, // Adjust the height as needed
            ),
            const SizedBox(width: 10),
            // Add some spacing between the image and text
            // const Text('Home'),
          ],
        ),
        // foregroundColor: Color(0xCC96614D),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout code
              showMySnackBar(
                context: context,
                message: 'Logging out...',
                color: Colors.red,
              );

              context.read<HomeCubit>().logout(context);
            },
          ),
          // Switch(
          //   value: _isDarkTheme,
          //   onChanged: (value) {
          //     // Change theme
          //     // setState(() {
          //     //   _isDarkTheme = value;
          //     // });
          //   },
          // ),
        ],
      ),
      // body: _views.elementAt(_selectedIndex),
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return state.views.elementAt(state.selectedIndex);
      }),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.dashboard),
              //   label: 'Dashboard',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Pets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            currentIndex: state.selectedIndex,
            // selectedItemColor: Colors.white,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
            backgroundColor: const Color(0xFFFFCCAA),
            // selectedItemColor: const Color(0xFF66AEA6),
            selectedItemColor: const Color(0xFFB34A2E),
          );
        },
      ),
    );
  }
}
