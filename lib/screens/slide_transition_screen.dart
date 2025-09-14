import 'package:flutter/material.dart';

class SlideTransitionScreen extends StatefulWidget {
  const SlideTransitionScreen({super.key});

  @override
  State<SlideTransitionScreen> createState() => _SlideTransitionScreenState();
}

class _SlideTransitionScreenState extends State<SlideTransitionScreen> with SingleTickerProviderStateMixin{

  late final AnimationController _controller;
  late final Animation<Offset> _menuAnimation;
  final double _menuWidth = 250.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    // Slide from left: Offset(-1, 0) → Offset(0, 0)
    _menuAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No drawer: everything in the body
      body: Stack(
        children: [
          // 1) The sliding menu
          SlideTransition(
            position: _menuAnimation,
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
                        title: Text('Home', style: TextStyle(color: Colors.white)),
                        onTap: _toggleMenu,
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white),
                        title: Text('Settings', style: TextStyle(color: Colors.white)),
                        onTap: _toggleMenu,
                      ),
                      ListTile(
                        leading: Icon(Icons.contact_mail, color: Colors.white),
                        title: Text('Contact', style: TextStyle(color: Colors.white)),
                        onTap: _toggleMenu,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 2) Main content
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // Shift main content to the right as menu opens
              double slideAmount = _menuWidth * _controller.value;
              double scaleAmount = 1 - (_controller.value * 0.1);
              return Transform(
                transform: Matrix4.identity()
                  ..translate(slideAmount)
                  ..scale(scaleAmount, scaleAmount),
                alignment: Alignment.centerLeft,
                child: child,
              );
            },
            child: GestureDetector(
              // Close menu if you tap outside of it
              onTap: () {
                if (_controller.status == AnimationStatus.completed) {
                  _controller.reverse();
                }
              },
              child: AbsorbPointer(
                absorbing: _controller.status == AnimationStatus.completed,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('SlideTransition Menu'),
                    leading: IconButton(
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _controller,
                      ),
                      onPressed: _toggleMenu,
                    ),
                  ),
                  body: Center(
                    child: Text(
                      'Tap the menu icon to slide in/out.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );;
  }
}