import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _showPassword = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  String? _repasswordError;
  String? _nameError;
  String? _phoneError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    if (password.length < 6) return false;
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    return hasLetter && hasNumber;
  }

  bool _isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^[0-9]{10,}$');
    return phoneRegex.hasMatch(phone);
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
                          Icons.person_add,
                          color: Colors.deepPurple,
                          size: 80,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        errorText: _nameError,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _nameError = value.isEmpty
                              ? 'Full name is required'
                              : null;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
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
                          // Also check repassword if not empty
                          if (_repasswordController.text.isNotEmpty) {
                            if (_repasswordController.text != value) {
                              _repasswordError = 'Passwords do not match';
                            } else {
                              _repasswordError = null;
                            }
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _repasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                        errorText: _repasswordError,
                      ),
                      obscureText: !_showPassword,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _repasswordError = null;
                          } else if (value != _passwordController.text) {
                            _repasswordError = 'Passwords do not match';
                          } else {
                            _repasswordError = null;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Mobile Phone',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                        errorText: _phoneError,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _phoneError = null;
                          } else if (!_isValidPhone(value)) {
                            _phoneError = 'Enter a valid phone number';
                          } else {
                            _phoneError = null;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Example validation before register
                        setState(() {
                          _nameError = _nameController.text.isEmpty
                              ? 'Full name is required'
                              : null;
                          if (_emailController.text.isEmpty) {
                            _emailError = 'Email is required';
                          } else if (!_isValidEmail(_emailController.text)) {
                            _emailError = 'Invalid email format';
                          } else {
                            _emailError = null;
                          }
                          if (_passwordController.text.isEmpty) {
                            _passwordError = 'Password is required';
                          } else if (!_isValidPassword(
                            _passwordController.text,
                          )) {
                            _passwordError =
                                'Password must be at least 6 characters and include letters and numbers';
                          } else {
                            _passwordError = null;
                          }
                          if (_repasswordController.text.isEmpty) {
                            _repasswordError = 'Please confirm your password';
                          } else if (_repasswordController.text !=
                              _passwordController.text) {
                            _repasswordError = 'Passwords do not match';
                          } else {
                            _repasswordError = null;
                          }
                          if (_phoneController.text.isEmpty) {
                            _phoneError = 'Mobile phone is required';
                          } else if (!_isValidPhone(_phoneController.text)) {
                            _phoneError = 'Enter a valid phone number';
                          } else {
                            _phoneError = null;
                          }
                        });
                        // TODO: Implement register logic if all errors are null
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/login');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Login',
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
