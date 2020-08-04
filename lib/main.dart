import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps/maps.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: Maps(),
    );
  }
}



