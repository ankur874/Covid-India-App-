import 'package:flutter/material.dart';
import 'homePage.dart';
import 'data_source.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: primaryBlack,
    ),
    home: HomePage(),
  ));
}
