import 'package:flutter/material.dart';
import 'package:welcome_screen/screens/list_product_screen.dart';
import 'register_screen.dart';

// Firebase Auth imports
import 'package:firebase_auth/firebase_auth.dart';

// Google Sign-In imports
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  final Color _colors = Colors.white;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // bool _isValidPassword(String password) {
  //   if (password.length < 6) return false;
  //   final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
  //   final hasNumber = RegExp(r'[0-9]').hasMatch(password);
  //   return hasLetter && hasNumber;
  // }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      showModernAlertDialog(
        context,
        'Login Successful',
        'Welcome, ${googleUser.displayName ?? googleUser.email}!',
        const Color.fromARGB(255, 219, 247, 233),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListProductScreen()),
      );
    } catch (e) {
      showModernAlertDialog(
        context,
        'Login Failed',
        e.toString(),
        const Color.fromARGB(255, 254, 202, 202),
      );
    }
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // print('Login susessfully: ${email}');
      showModernSnackBar(
        context,
        'Login Successful',
        'Welcome back, $email!',
        const Color.fromARGB(255, 219, 247, 233),
      );

      // Login successful, navigate to dashboard or home
      Future.delayed(const Duration(seconds: 2), () {
        // Code to run after 2 seconds
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListProductScreen()),
        );
      });
    } on FirebaseAuthException catch (e) {
      // Handle error (e.g., show error message)
      // print('Login error: ${e.message}');
      showModernSnackBar(
        context,
        'Login Failed',
        e.message ?? 'An unknown error occurred.',
        const Color.fromARGB(255, 254, 202, 202),
      );
    }
  }

  Future<void> showModernSnackBar(
    BuildContext context,
    String title,
    String message,
    Color color,
  ) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.deepPurple),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(message, style: const TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showModernAlertDialog(
    BuildContext context,
    String title,
    String message,
    Color colors,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.deepPurple),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(message, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 202, 132, 255), // Sky blue
              Color.fromARGB(255, 160, 177, 254), // Powder blue
              Color(0xFFE0FFFF), // Light cyan
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Colors.deepPurple,
                          size: 80,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Welcome! Please login to continue.',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        errorText: _emailError,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _emailError = null;
                          } else if (!_isValidEmail(value)) {
                            _emailError = 'Invalid email format';
                          } else {
                            _emailError = null;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                        errorText: _passwordError,
                      ),
                      obscureText: !_showPassword,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _passwordError = null;
                          } else if (value.length < 6) {
                            _passwordError =
                                'Password must be at least 6 characters';
                          } else if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
                              !RegExp(r'[0-9]').hasMatch(value)) {
                            _passwordError =
                                'Password must include letters and numbers';
                          } else {
                            _passwordError = null;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement forgot password
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement login logic
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ListProductScreen(),
                        //   ),

                        loginWithEmailPassword(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),

                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('or'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement Google sign-in
                        loginWithGoogle();
                      },
                      icon: const Icon(Icons.account_circle, color: Colors.red),
                      label: const Text('Sign in with Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement GitHub sign-in
                      },
                      icon: const Icon(Icons.code, color: Colors.black),
                      label: const Text('Sign in with GitHub'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/register');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
