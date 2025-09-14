import 'package:flutter/material.dart';

class SlideMenuScreen extends StatefulWidget {
  const SlideMenuScreen({super.key});

  @override
  State<SlideMenuScreen> createState() => _SlideMenuScreenState();
}

class _SlideMenuScreenState extends State<SlideMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Add your Drawer here
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle navigation
                print('Home tapped');
                Navigator.pop(context); // close drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                print('Settings tapped');
                Navigator.pop(context);
                // Navigate to settings page
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact'),
              onTap: () {
                print('Contact tapped');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Slide Menu on AppBar'),
        // 2. Use the automatically provided menu icon to open the drawer
        //    (if you omit leading, Flutter shows it for you)
      ),
      body: Center(
        child: Text(
          'Swipe from the left or tap the menu icon\nto open the slide menu.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
