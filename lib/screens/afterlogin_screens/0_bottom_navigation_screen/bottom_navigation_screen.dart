import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/screen/home_screen.dart';
import 'package:insure_mate/screens/afterlogin_screens/2_search/screen/search_screen.dart';
import 'package:insure_mate/screens/afterlogin_screens/3_profile/screen/profile_screen.dart';
import 'package:insure_mate/theme/app_text_style.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

  int _currentSelectedIndex = 0;

  List<Widget> _allWidgets = [HomeScreen(), SearchScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentSelectedIndex,
        children: _allWidgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: AppString.homeText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: AppString.searchText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: AppString.profileText,
          ),
        ],
        onTap: _onItemTapped,
        selectedLabelStyle: AppTextStyle.selectedBottomNavItem,
        unselectedLabelStyle: AppTextStyle.bodyMedium,
      ),
    );
  }

  void _onItemTapped(int selectedIndex) {
    setState(() {
      _currentSelectedIndex = selectedIndex;
    });
  }
}
