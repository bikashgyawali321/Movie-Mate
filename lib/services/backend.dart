// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/models/movie.dart';

class BackendService extends ChangeNotifier {
  String apiKey = "87be5137";
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://www.omdbapi.com/'));

  Future<List<Movie>> getMovies(String searchValue) async {
    try {
      Response response = await _dio.get(
        '?apikey=$apiKey&s=$searchValue',
      );
      print(response.data);
      List<dynamic> data = response.data['Search'];

      List<Movie> movies =
          data.map<Movie>((json) => Movie.fromJson(json)).toList();

      return movies;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Movie> getMovieDetails(String id) async {
    try {
      Response response = await _dio.get('?apikey=$apiKey&i=$id');
      Map<String, dynamic> data = response.data;
      Movie movie = Movie.fromJson(data);
      print(response);
      return movie;
    } catch (e) {
      print('Error in backend file');
      print(e);
      rethrow;
    }
  }
}
