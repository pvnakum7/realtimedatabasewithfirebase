import 'package:flutter/material.dart';
import 'package:realtimedatabasewithfirebase/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F68),
        accentColor: const Color(0xFF167F67),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      home: new MyHomePage(),
    );
  }
}

