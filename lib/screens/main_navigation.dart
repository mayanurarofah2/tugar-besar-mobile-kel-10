import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  // Fungsi untuk kembali ke Home
  void goHome() {
    setState(() => index = 0);
  }

  @override
  Widget build(BuildContext context) {
   final screens = [
  HomeScreen(),
  SearchScreen(onBackToHome: goHome),
  CartScreen(onBackToHome: goHome),
  ProfileScreen(),
];


    return Scaffold(
      body: screens[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.brown[300],
        type: BottomNavigationBarType.fixed,

        onTap: (i) => setState(() => index = i),

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
