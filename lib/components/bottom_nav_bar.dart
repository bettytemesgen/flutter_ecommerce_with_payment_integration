import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)?
  onTabChange; //pass funcation that receive the indesx of selected tab
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: const Color.fromARGB(255, 209, 206, 206),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ), // smaller size
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabBorderRadius: 12,
        iconSize: 30,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        onTabChange: (value) => onTabChange!(
          value,
        ), //When the tab is changed, call the onTabChange function and give it the new tab index
        tabs: const [
          GButton(icon: Icons.home, text: ''),
          GButton(icon: Icons.shopping_bag_rounded, text: ''),
          GButton(icon: Icons.phone, text: ''),
          GButton(icon: Icons.person, text: ''),
        ],
      ),
      // child: Gnav,
    );
  }
}
