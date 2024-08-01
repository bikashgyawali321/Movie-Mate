import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/movies_providers.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 350,
        child: SearchBar(
          hintText: 'Search....',
          controller: controller,
          onChanged: (value) => context.read<MovieProvider>().getMovies(value),
          trailing: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  Provider.of<MovieProvider>(context, listen: false)
                      .getMovies(controller.text);

                  controller.clear();
                },
                icon: const Icon(Icons.search),
              ),
            )
          ],
        ),
      ),
    );
  }
}
