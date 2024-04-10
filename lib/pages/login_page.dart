import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      final Dio dio = Dio();
      final response = await dio.post(
        'http://10.0.2.2:3000/api/users/login', // Replace this with your actual login API URL
        data: {
          'username': username,
          'password': password,
        },
      );

      // Check response status code
      if (response.statusCode == 200) {
        // Login successful
        print('Login successful: ${response.data}');

        // Navigate to the job page
        Navigator.pushNamed(context, '/job');
      } else {
        // Login failed
        print('Login failed: ${response.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${response.data}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Handle Dio errors
      print('Error logging in: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging in: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const _Header(),
            _inputField(_usernameController, 'Username'),
            _inputField(_passwordController, 'Password', isPassword: true),
            const _ForgotPassword(),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.purple,
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            _signup(context),
          ],
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String hintText, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.purple.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(isPassword ? Icons.password : Icons.person),
      ),
      obscureText: isPassword,
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            // Navigate to signup page
            Navigator.pushNamed(context, '/signup');
          },
          child: const Text("Sign Up", style: TextStyle(color: Colors.purple)),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Handle forgot password logic here
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }
}
