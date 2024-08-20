import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class AppBarWidget extends StatelessWidget {
  final String title;

  const AppBarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return AppBar(
      elevation: 5,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                    MediaQuery.of(context).size.width * 0.8, 30, 10, 0),
                items: [
                  _buildPopUpMenuItem(context, themeProvider,
                      Icons.brightness_auto, 'System', ThemeMode.system),
                  _buildPopUpMenuItem(context, themeProvider, Icons.light_mode,
                      'Light', ThemeMode.light),
                  _buildPopUpMenuItem(context, themeProvider, Icons.dark_mode,
                      'Dark', ThemeMode.dark)
                ]);
          },
          icon: Icon(themeProvider.themeMode == ThemeMode.dark
              ? Icons.dark_mode
              : themeProvider.themeMode == ThemeMode.light
                  ? Icons.light_mode
                  : Icons.brightness_auto),
          iconSize: 30,
        ),
      ],
    );
  }

  PopupMenuItem<ThemeMode> _buildPopUpMenuItem(
      BuildContext context,
      ThemeProvider themeProvider,
      IconData icon,
      String title,
      ThemeMode value) {
    return PopupMenuItem(
        value: value,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon),
          title: Text(title),
          trailing:
              themeProvider.themeMode == value ? const Icon(Icons.check) : null,
          onTap: () {
            themeProvider.setTheme(value);
            Navigator.pop(context);
          },
        ));
  }
}
