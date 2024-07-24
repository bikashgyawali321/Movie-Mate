// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarDialog extends StatefulWidget {
  const RatingBarDialog({super.key});

  @override
  State<RatingBarDialog> createState() => _RatingBarDialogState();
}

class _RatingBarDialogState extends State<RatingBarDialog> {
  num userRating = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Rate this movie"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Please leave a star rating:'),
          SizedBox(
            height: 15,
          ),
          RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) =>
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              
              onRatingUpdate: (ratings) => userRating = ratings)
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Submit')),
      ],
    );
  }
}
