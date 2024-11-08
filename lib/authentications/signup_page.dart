import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/authentications/auth_controller.dart';
import 'package:tripmate/authentications/signin_page.dart';
import 'package:tripmate/Pages/welcome_page.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign up',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Create your account',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 30),
                
                // Username
                buildFieldTitle('Username'),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple[50],
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Email
                buildFieldTitle('Email'),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple[50],
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Phone Number
                buildFieldTitle('Phone Number'),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple[50],
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),

                // Date of Birth
                buildFieldTitle('Date of Birth'),
                TextField(
                  controller: _birthDateController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple[50],
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'Select your date of birth',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      _birthDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                    }
                  },
                ),
                SizedBox(height: 20),

                // Password
                buildFieldTitle('Password'),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple[50],
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: !_showPassword,
                ),
                SizedBox(height: 20),

                // Confirm Password
                buildFieldTitle('Confirm Password'),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple[50],
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Re-enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(_showConfirmPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: !_showConfirmPassword,
                ),
                SizedBox(height: 20),

                // Sign Up Button
                Obx(() => authController.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => _signUp(),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(22, 86, 182, 1),
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )),
                SizedBox(height: 10),

                // Redirect to Login
                TextButton(
                  onPressed: () => Get.to(SignInScreen()),
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(color: Color.fromRGBO(22, 86, 182, 1),),
                        ),
                      ],
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }
    final message = await authController.signUp(
      _emailController.text,
      _passwordController.text,
      _nameController.text,
      phoneNumber: _phoneController.text,
      birthDate: _birthDateController.text,
    );
    if (message == null) {
      Get.offAll(() => WelcomePage());
    } else {
      Get.snackbar('Error', message);
    }
  }

  Widget buildFieldTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
