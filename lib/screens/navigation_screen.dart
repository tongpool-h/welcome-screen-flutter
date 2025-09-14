import 'package:flutter/material.dart';
import 'package:welcome_screen/screens/welcome_screen.dart';

import 'home_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    WelcomeScreen(),
    WelcomeScreen(),  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Navigation Screen'),
      //   backgroundColor: Colors.blue,
      // ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white, // Set navigation bar background color
        selectedItemColor: const Color.fromARGB(
          255,
          53,
          90,
          251,
        ), // Color for selected item
        unselectedItemColor: const Color.fromARGB(
          179,
          21,
          21,
          21,
        ), // Color for unselected items
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Roboto', // Replace with your font family
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Roboto', // Replace with your font family
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // Handle navigation logic here
          setState(() {
            _currentIndex = index;
            
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => _screens[index]),
            // );
          });
          print('Selected index: $index');
        },
      ),
    );
  }
}
