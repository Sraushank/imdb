import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/movies/movies_model.dart';

class ApiService {
  final String apiUrl = 'https://imdb-top-100-movies.p.rapidapi.com/series';
  final String apiKey = '201746b64fmsh4c6cf7534e0fa7fp19696cjsn0d24a6cb1cc5';

  Future<List<Movies>> fetchSeries() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-rapidapi-host': 'imdb-top-100-movies.p.rapidapi.com',
        'x-rapidapi-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Movies.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load series');
    }
  }
}
