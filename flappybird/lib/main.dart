import 'package:flutter/material.dart';

import 'anasayfa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debug yazisi kalksin diye
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}