// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final Function(String password) onChanged;
  bool isVisible = false;

  PasswordField({
    super.key,
    required this.isVisible,
    required this.onChanged,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !widget.isVisible,
      onChanged: (value) => widget.onChanged(value),
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.isVisible = !widget.isVisible;
            });
          },
          icon:
              Icon(widget.isVisible ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
