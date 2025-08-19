import 'package:flutter/material.dart';
import 'package:projectone/components/bottom_nav_bar.dart';
import 'package:projectone/pages/About_page.dart';
import 'package:projectone/pages/cart_page.dart';
import 'package:projectone/pages/intro_page.dart';
import 'package:projectone/pages/shop_page.dart';
import 'package:projectone/pages/profile_page.dart';
import 'contact_page.dart';
import 'package:projectone/components/profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  //creates the mutable state _HomepageState
  State<Homepage> createState() => _HomepageState();
}

//actual state class that contro the UI and logic
class _HomepageState extends State<Homepage> {
  //variable to track which tab is selected
  int _selectesIndex = 0;
  //keep tracks which tab is creently(0=shoppage,1=cartpage)
  void navigateBottomBar(int index) {
    setState(() {
      _selectesIndex = index; //updates the selected tab index
    });
  }

  //pages to display
  final List<Widget> _pages = [
    //stores the two pages
    //shop page
    const ShopPage(), //index 0 shop page
    //cart page
    const CartPage(), //index 1 cart page
    const ContactPage(),
    const ProfilePage(),
    const IntroPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //orginaze the ul content
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) =>
            navigateBottomBar(index), //when tab is tapped call funcation
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, //remove  shadow
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Profile(radius: 20),
          ),
        ],
        leading: Builder(
          //addinf menu icon on the left
          builder: (context) => IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: const Icon(Icons.menu, color: Colors.black),
            ),
            onPressed: () {
              Scaffold.of(
                context,
              ).openDrawer(); //open the drawer icon  when is pressed
            },
          ),
        ),
      ),

      //side drawer menu
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          children: [
            // ───── Top Section ─────
            DrawerHeader(
              child: Image.asset(
                'assets/images/nike-logo.png',
                color: Colors.white,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(color: Colors.grey[800]),
            ),

            // Home Link
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context); // close drawer
                  setState(() => _selectesIndex = 0); // show shop page
                },
              ),
            ),
            // Info Link
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _selectesIndex = 3); // show Profile page
                },
              ),
            ),

            //Conatact Page
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                leading: const Icon(
                  Icons.contact_page_outlined,
                  color: Colors.white,
                ),
                title: Text("Contact", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _selectesIndex = 3);
                },
              ),
            ),

            // ───── Spacer pushes content to bottom ─────
            const Spacer(),

            // ───── Logout at the Bottom ─────
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 20.0),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _selectesIndex = 4); // show About page
                },
              ),
            ),
          ],
        ),
      ),
      //dispaly the selected page (either shoppage or cartpage)
      body: _pages[_selectesIndex],
    );
  }
}
