import 'package:flutter/material.dart';
import 'package:welcome_screen/screens/curved_navbar_screen.dart';
import 'package:welcome_screen/screens/login_screen.dart';
import 'package:welcome_screen/screens/slide_animation_screen.dart';
import 'package:welcome_screen/screens/slide_menu_screen.dart';
import 'package:welcome_screen/screens/slide_transition_screen.dart';

import 'screens/home_screen.dart';

import 'screens/navigation_screen.dart';
import 'screens/welcome_screen.dart';

// Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Fix Code: Unused main method
// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Screen',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF6200EE), // Primary color
          secondary: const Color(0xFF03DAC6), // Secondary color
          surface: const Color.fromARGB(255, 248, 202, 202), // Background color
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6200EE), // Primary color for headings
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black87, // Body text color
          ),
        ),
      ),
      // home: const WelcomeScreen(),
      // home: HomeScreen(),
      // home: const NavigationScreen(),
      // home: CurvedNavbarScreen(),
      home: LoginScreen(),
      // home: SlideTransitionScreen(),
      // home: CurvedNavbarScreen(),
    );
  }
}
