import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog'),
      ),
      body: ListView(
        children: [
          BlogPost(
            title: 'Lorem Ipsum',
            imageUrl: 'https://via.placeholder.com/300',
            content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur, libero at suscipit tincidunt, arcu elit tempor metus, non efficitur sapien ex nec nibh. Phasellus sed lorem eu turpis mattis fermentum vel sit amet odio. ',
          ),
          BlogPost(
            title: 'Dolor Sit Amet',
            imageUrl: 'https://via.placeholder.com/300',
            content:
            'Duis id justo quis velit laoreet iaculis sed nec tortor. Nullam semper, tortor non dictum placerat, magna arcu congue arcu, eget aliquet ante nunc nec felis.',
          ),
          // Add more BlogPost widgets here as needed
        ],
      ),
    );
  }
}

class BlogPost extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String content;

  BlogPost({
    required this.title,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  content,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BlogPage(),
  ));
}
