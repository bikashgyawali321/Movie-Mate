// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movie_mate/models/movie.dart';
import 'package:provider/provider.dart';
import '../provider/movies_providers.dart';
import '../widgets/appbar.dart';
import '../widgets/rating_bar.dart';

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

  num? userRatings;
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
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          final detail = _details;

          if (detail == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.1,
                    child: Image.network(
                      detail.poster!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black12,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.plot!,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.yellow,
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
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              detail.runtime!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'Genre:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              detail.genre!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              'Production:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              detail.production!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 17),
                            const Spacer(),
                            const Text(
                              'Meta Score:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              detail.metascore!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Director:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                detail.director!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'Released Year:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              detail.year,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Cast:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                detail.actors!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (detail.ratings != null &&
                            detail.ratings!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ratings:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              ...detail.ratings!.map((rating) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          rating['Source'] ?? '',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        rating['Value'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  if (userRatings == null)
                    Center(
                      child: Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(18)),
                          child: TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Rate ${widget.movieName}',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      );
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
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
