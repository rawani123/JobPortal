import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/blog_page.dart';
import 'package:flutter_application_1/pages/login_page.dart'; // Import your LoginPage widget
import 'package:flutter_application_1/pages/register_page.dart'; // Import your SignupPage widget
import 'package:flutter_application_1/pages/BlogApi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      initialRoute: '/login', // Set the initial route to the login page
      routes: {
        '/login': (context) => LoginPage(), // Define the route for the LoginPage
        '/signup': (context) => SignupPage(), // Define the route for the SignupPage
        '/blog': (context) => BlogPage(),
        '/job': (context) => JobSearchPage() // Define the route for the BlogPage
      },
    );
  }
}
