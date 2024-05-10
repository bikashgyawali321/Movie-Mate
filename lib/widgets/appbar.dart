import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;

  const AppBarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 4, 13, 12),
      elevation: 5,
      automaticallyImplyLeading: false,
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.blueGrey.shade200),
      title: Text(
        title,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }
}
