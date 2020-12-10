import 'package:flutter/material.dart';

class Engeller extends StatelessWidget {
  final boyut;
  Engeller({this.boyut});

  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: boyut,

     decoration: BoxDecoration(
      color: Colors.green,
      border: Border.all(width: 10, color: Colors.green[800]),
      borderRadius: BorderRadius.circular(15)
      ),

    );
  }
}
