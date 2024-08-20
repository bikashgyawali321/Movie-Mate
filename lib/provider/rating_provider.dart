import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RatingProvider extends ChangeNotifier {
  Map<String, double> _ratings = {};

  double getUserRating(String id) {
    //if the rating is already in memory

    if (_ratings.containsKey(id)) {
      return _ratings[id]!;
    }
    final box = Hive.box('UserData');
    return box.get('userRatingOnMovie_$id', defaultValue: 0.0);
  }

  void addUserRating(String id, double userRating) async {
    final box = await Hive.openBox('UserData');
    await box.put('userRatingOnMovie_$id', userRating);
    _ratings[id] = userRating;
    notifyListeners();
  }
}
