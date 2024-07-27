// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:movie_mate/provider/movies_providers.dart';
import 'package:movie_mate/widgets/appbar.dart';
import 'package:movie_mate/widgets/search_bar.dart';

import 'package:provider/provider.dart';

import 'movie_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building home screen');
    Provider.of<MovieProvider>(context, listen: false).movie;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          title: 'MOVIE MAGIC',
        ),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, value, child) {
          final movies = value.movies;
          final scrollController = ScrollController();
          bool isScrollbarVisible = false;

          void toggleScrollbarVisibility() {
            isScrollbarVisible = !isScrollbarVisible;
            if (isScrollbarVisible) {
              Future.delayed(const Duration(seconds: 2), () {
                if (isScrollbarVisible) {
                  isScrollbarVisible = false;
                  scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                }
              });
            }
          }

          return Listener(
            onPointerDown: (_) {
              toggleScrollbarVisibility();
            },
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const SizedBox(
                      width: double.infinity, child: SearchBarWidget()),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Scrollbar(
                      thumbVisibility: isScrollbarVisible,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MovieDetailsScreen(
                                        id: movie.id!,
                                        movieName: movie.title,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: "movie/${movie.poster}",

                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(1, 2, 3, 2),
                                    child: SizedBox(
                                      height: 200,
                                      width: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.network(
                                          movie.poster!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (movies.isEmpty)
                    Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade200),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
