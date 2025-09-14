import 'package:flutter/material.dart';

class SlideAnimationScreen extends StatefulWidget {
  const SlideAnimationScreen({super.key});

  @override
  State<SlideAnimationScreen> createState() => _SlideAnimationScreenState();
}

class _SlideAnimationScreenState extends State<SlideAnimationScreen> {
  
  // Track whether the menu is open
  bool _isMenuOpen = false;
  // Width of the slide menu
  final double _menuWidth = 250.0;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We remove the default Drawer; everything lives in the body stack
      body: Stack(
        children: [
          // 1) The sliding menu
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            left: _isMenuOpen ? 0 : -_menuWidth,
            child: SizedBox(
              width: _menuWidth,
              child: Material(
                color: Colors.blue,
                elevation: 8,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Menu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(color: Colors.white70),
                      ListTile(
                        leading: Icon(Icons.home, color: Colors.white),
                        title: Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // navigate...
                          _toggleMenu();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white),
                        title: Text(
                          'Settings',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // navigate...
                          _toggleMenu();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.contact_mail, color: Colors.white),
                        title: Text(
                          'Contact',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // navigate...
                          _toggleMenu();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 2) The main content that shifts and rounds when the menu is open
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            left: _isMenuOpen ? _menuWidth : 0,
            right: _isMenuOpen ? -_menuWidth : 0,
            child: Material(
              // Add a subtle elevation and rounded corners when menu is open
              elevation: _isMenuOpen ? 8 : 0,
              borderRadius: _isMenuOpen
                  ? BorderRadius.circular(16)
                  : BorderRadius.zero,
              child: ClipRRect(
                // clip the rounded corners
                borderRadius: _isMenuOpen
                    ? BorderRadius.circular(16)
                    : BorderRadius.zero,
                child: GestureDetector(
                  // close the menu if you tap on the shaded content
                  onTap: () {
                    if (_isMenuOpen) _toggleMenu();
                  },
                  child: AbsorbPointer(
                    // disable interactions when menu is open
                    absorbing: _isMenuOpen,
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text('Custom Slide Menu'),
                        leading: IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: _toggleMenu,
                        ),
                      ),
                      body: Center(
                        child: Text(
                          'Tap the menu icon or swipe\nto open the slide menu.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
