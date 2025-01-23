import 'package:flutter/material.dart';

class ColorGradients {
  final gradientBackground = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [
        0.1,
        0.3,
        0.5,
        0.7,
        0.9
      ],
      colors: [
        Colors.deepOrange[300] ?? Colors.deepOrange,
        Colors.deepOrange[400] ?? Colors.deepOrange,
        Colors.deepOrange[500] ?? Colors.deepOrange,
        Colors.deepOrange[600] ?? Colors.deepOrange,
        Colors.deepOrange[700] ?? Colors.deepOrange,
      ]);
}
