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
  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const ChatScreen(),
    const ProfileView(),
  ];

  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            'assets/images/fureverHome_logo.png',
            height: 100,
            width: 100,
          ),
        ),
        title: const Text(
          "Welcome",
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 20),
        //     child: Row(
        //       children: [
        //         Icon(Icons.search),
        //         SizedBox(width: 16), // Space between the icons
        //         Icon(Icons.notifications),
        //       ],
        //     ),
        //   ),
        // ],
        centerTitle: false, // Align the title to the left
      ),
      body: lstBottomScreen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color(0xFFFCDDC9),
        // selectedItemColor: const Color(0xFF66AEA6),
        selectedItemColor: const Color(0xCC96614D),
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(0, Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(1, Icons.chat_bubble),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(2, Icons.person),
            label: "Profile",
          ),
        ],
        onTap: _onTabSelected,
      ),
    );
  }

  Widget _buildIcon(int index, IconData icon) {
    final bool isSelected = _currentIndex == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 2,
            width: 24,
            color: const Color(0xFF66AEA6), // Line color
          ),
      ],
    );
  }
}
