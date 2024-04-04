import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the LoginPage widget from its file
import 'package:dio/dio.dart'; // Import dio package

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final Dio _dio = Dio();
  static const String baseUrl = 'http://10.0.2.2:3000/api/users/';

  Future<void> _signUp(BuildContext context, String username, String email,
      String password) async {
    try {
      final response = await _dio.post(
        '${baseUrl}register',
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      // Check if the signup was successful
      if (response.statusCode == 201) {
        // Show success message
        print('Signup successful: ${response.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup successful'),
            backgroundColor: Colors.green,
          ),
        );
        // Redirect to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        // Show error message
        print('Signup failed: ${response.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup failed: ${response.data}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Handle network errors
      print('Error signing up: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing up: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = '';
    String email = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 60.0),
            const Text(
              "Sign up",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Create your account",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: const Icon(Icons.person),
              ),
              onChanged: (value) => username = value,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(Icons.email),
              ),
              onChanged: (value) => email = value,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.password),
              ),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _signUp(context, username, email, password);
              },
              child: const Text(
                "Sign up",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            const Center(child: Text("Or")),
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.purple),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  // Perform sign in with Google logic
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/login_signup/google.png'),
                        radius: 15,
                      ),
                    ),
                    SizedBox(width: 18),
                    Text(
                      "Sign In with Google",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.purple),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
