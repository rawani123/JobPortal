import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JobSearchService {
  Future<Map<String, dynamic>> searchJobs({required String query, required String location, required int page}) async {
    final String url = 'http://10.0.2.2:3000/api/users/searchJobs'; // Update with your backend API endpoint
    final Map<String, String> queryParameters = {
      'query': query,
      'location': location,
      'page': page.toString(),
    };

    final Uri uri = Uri.parse(url).replace(queryParameters: queryParameters);

    try {
      final http.Response response = await http.get(uri);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(response.body);
        return responseData;
      } else {
        throw Exception('Failed to load jobs: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load jobs: $error');
    }
  }
}

class JobSearchPage extends StatefulWidget {
  @override
  _JobSearchPageState createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final JobSearchService _jobSearchService = JobSearchService();
  Map<String, dynamic> _jobData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Search'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final Map<String, dynamic> responseData = await _jobSearchService.searchJobs(
                query: 'Software developer',
                location: 'Europe',
                page: 1,
              );
              setState(() {
                _jobData = responseData;
              });
            } catch (error) {
              // Handle error
              print('Error: $error');
            }
          },
          child: Text('Search Jobs'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Job Search App',
    home: JobSearchPage(),
  ));
}
