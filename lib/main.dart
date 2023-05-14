import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MaterialApp(
        title: 'Ariana Grande',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        home: const Home(),
      ),
    );
  }
}

