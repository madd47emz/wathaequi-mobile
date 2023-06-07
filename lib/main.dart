import 'package:flutter/material.dart';
import 'package:wathaequi/views/1-splash.dart';
import 'package:wathaequi/views/5-feeds.dart';
import 'package:wathaequi/views/6-find.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wathaequi',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
