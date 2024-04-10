import 'dart:convert';
import 'package:http/http.dart' as http;

class JobSearchService {
  Future<Map<String, dynamic>> searchJobs({required String query, required String location, required int page}) async {
    final String apiKey = '7a58a188a3mshfabb492a690ceedp1bd3e8jsnc244c871b93b';
    final String url = 'https://linkedin-data-scraper.p.rapidapi.com/search_jobs';
    final Map<String, String> queryParameters = {
      'query': query,
      'location': location,
      'page': page.toString(),
    };

    final Uri uri = Uri.parse(url).replace(queryParameters: queryParameters);
    final Map<String, String> headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'linkedin-data-scraper.p.rapidapi.com',
    };

    try {
      final http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception('Failed to load jobs: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load jobs: $error');
    }
  }
}
