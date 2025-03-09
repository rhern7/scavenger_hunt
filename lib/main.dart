import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ScavengerHomePage(title: 'Scavenger Home'),
    );
  }
}

class ScavengerItem {
  final String hint;
  final String imagePath;
  bool found;

  ScavengerItem({
    required this.hint,
    required this.imagePath,
    this.found = false,
  });
}

class ScavengerHomePage extends StatefulWidget {
  const ScavengerHomePage({super.key, required this.title});

  final String title;

  @override
  State<ScavengerHomePage> createState() => _ScavengerHomePageState();
}

class _ScavengerHomePageState extends State<ScavengerHomePage> {
  // Sample data model for items in the scavenger hunt. Need to replace later with actual pictures
  final List<ScavengerItem> items = [
    ScavengerItem(
      hint: 'Tall building with a huge clock on top!',
      imagePath: 'assets/images/clocktower.jpg',
    ),
    ScavengerItem(
      hint: 'A place where students gather to eat and chat.',
      imagePath: 'assets/images/cafeteria.jpg',
    ),
    ScavengerItem(
      hint: 'Historic library known for its ancient manuscripts.',
      imagePath: 'assets/images/library.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text(
          'Data model added, next step is to display it!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
