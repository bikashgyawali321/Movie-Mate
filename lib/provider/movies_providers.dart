import 'package:flutter/material.dart';

import 'package:movie_mate/models/movie.dart';
import 'package:movie_mate/services/backend.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> movies = [];
  List<Movie> get movie => movies;
  BackendService dioService = BackendService();

  Future<List<Movie>> getMovies(String searchData) async {
    movies = await dioService.getMovies(searchData);
    notifyListeners();

    return movies;
  }

  Movie? _movieDetails;
  Movie? get getMovieDetails => _movieDetails;
  Future<Movie> getMovieDetail(String id) async {
    _movieDetails = (await dioService.getMovieDetails(id));

    notifyListeners();
    return _movieDetails!;
  }
}
