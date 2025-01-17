import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tickit/pages/home.dart';
import 'package:tickit/provider/provider.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('mybox');

  runApp(
    ChangeNotifierProvider(
      create: (context) => ToDoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
