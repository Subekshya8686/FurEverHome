import 'package:flutter/material.dart';
import 'package:furever_home/view/chat_screen.dart';
import 'package:furever_home/view/home_screen.dart';
import 'package:furever_home/view/profile_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const ChatScreen(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            )),
      ),
      // body: const Center(
      //   child: Column(
      //     children: [
      //       Text("This is a dashboard page",
      //           style: TextStyle(
      //             fontSize: 24,
      //           )),
      //       PetProfileCardView(),
      //     ],
      //   ),
      // ),
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
