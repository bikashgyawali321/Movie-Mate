// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_mate/models/movie.dart';
import 'package:provider/provider.dart';
import '../provider/movies_providers.dart';
import '../widgets/appbar.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String id;
  final String movieName;

  const MovieDetailsScreen({
    super.key,
    required this.id,
    required this.movieName,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  Movie? _details;

  double? userRatings;
  @override
  void initState() {
    super.initState();
    loadMovieDetail();
  }

  void loadMovieDetail() {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.getMovieDetail(widget.id).then((value) {
      setState(() {
        _details = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          title: widget.movieName.toUpperCase(),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<MovieProvider>(
          builder: (context, movieProvider, child) {
            final detail = _details;

            if (detail == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "movieTag",
                    child: AspectRatio(
                      aspectRatio: 1.1,
                      child: Image.network(
                        detail.poster!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black12,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.plot!,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              'Duration:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              detail.runtime!,
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Genre:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              detail.genre!,
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Production:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              detail.production!,
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Released Date:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              detail.released!,
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Meta Score:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              detail.metascore!,
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Text(
                                'Director:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                detail.director!,
                                style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                'Cast:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                detail.actors!,
                                style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (detail.ratings != null &&
                            detail.ratings!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ratings:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              ...detail.ratings!.map((rating) {
                                return Row(
                                  children: [
                                    Text(
                                      " ${rating['Source'] ?? ''}:",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      rating['Value'] ?? 'N/A',
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              if (userRatings == null)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        child: TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) {
                                                    return AlertDialog(
                                                        title: Text(
                                                          'Rate ${widget.movieName}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge,
                                                        ),
                                                        actions: <Widget>[
                                                          Center(
                                                            child: Text(
                                                              "Please leave star ratings",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Center(
                                                            child: Column(
                                                              children: [
                                                                RatingBar.builder(
                                                                    initialRating:
                                                                        0,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    itemBuilder: (context, _) => Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .amber),
                                                                    onRatingUpdate:
                                                                        (rating) =>
                                                                            userRatings =
                                                                                rating
                                                                    //     setState(() {
                                                                    //   userRatings = rating;
                                                                    // }),
                                                                    ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            18),
                                                                  ),
                                                                  child:
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              userRatings;
                                                                            });
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Submit',
                                                                            style:
                                                                                Theme.of(context).textTheme.headlineSmall,
                                                                          )),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ]);
                                                  }));
                                            },
                                            child: Text(
                                              'Rate ${widget.movieName}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              if (userRatings != null)
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Your ratings',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        RatingBarIndicator(
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemSize: 18,
                                          rating: userRatings ?? 0,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text('($userRatings/5)',
                                            style: TextStyle(fontSize: 14))
                                      ],
                                    )),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
