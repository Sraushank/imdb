import 'package:flutter/material.dart';
import 'package:imdb/models/movies/movies_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeriesProvider extends ChangeNotifier {
  final String apiUrl = 'https://imdb-top-100-movies.p.rapidapi.com/series';
  final String apiKey = '201746b64fmsh4c6cf7534e0fa7fp19696cjsn0d24a6cb1cc5';

  List<Movies> _seriesList = [];
  List<Movies> _filteredSeriesList = [];
  bool _isLoading = false;
  String _searchQuery = "";

  List<Movies> get seriesList => _filteredSeriesList.isEmpty ? _seriesList : _filteredSeriesList;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  Future<void> fetchSeriesData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'x-rapidapi-host': 'imdb-top-100-movies.p.rapidapi.com',
          'x-rapidapi-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _seriesList = data.map((json) => Movies.fromJson(json)).toList();
        _filteredSeriesList = _seriesList; // Initially show all series
      } else {
        throw Exception('Failed to load series');
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _filteredSeriesList = _seriesList.where((series) {
      return series.title?.toLowerCase().contains(query.toLowerCase()) ?? false;
    }).toList();
    notifyListeners();
  }
}
