import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String title;
  const AppHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Header $title',
      style: const TextStyle(color: Colors.yellow),
    );
  }
}
