import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.book,size: 40,));
  }
}