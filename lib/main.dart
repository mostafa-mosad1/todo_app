import 'package:flutter/material.dart';

import 'BottonNavigationBarWithDateBase.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: home3()
    );
  }
}
