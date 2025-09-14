import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:welcome_screen/constant/constant.dart';

class CurvedNavbarScreen extends StatefulWidget {
  const CurvedNavbarScreen({super.key});

  @override
  State<CurvedNavbarScreen> createState() => _CurvedNavbarScreenState();
}

class _CurvedNavbarScreenState extends State<CurvedNavbarScreen> {

  int _page = 0;
  final _pages = [
    Center(child: Text("Home Page", style: headingTextStyle)),
    Center(child: Text("Search Page", style: headingTextStyle)),
    Center(child: Text("Profile Page", style: headingTextStyle)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pages[_page],
    );
  }
}
