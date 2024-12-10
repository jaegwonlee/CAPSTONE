import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/pages/community_page.dart';
import 'package:flutter_application_2/ui/pages/profile.dart';
import 'package:flutter_application_2/ui/pages/shop.dart';
import 'package:flutter_application_2/ui/pages/home.dart';
import 'dart:async';

class MainView extends StatefulWidget {
  MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    HomePage(token: ''),
    ShopPage(),
    CommunityPage(),
    Profile(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          selectedItemColor: Color(0x88009223),
          selectedLabelStyle: TextStyle(
            color: Colors.white,
          ),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.white),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: '샵'),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: '커뮤니티'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MY'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onNavTapped,
        ),
      ),
    );
  }
}
