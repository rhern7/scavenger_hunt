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
//replace with real pictures and hints once you have pictures
class _ScavengerHomePageState extends State<ScavengerHomePage> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            childAspectRatio: 1.0, // make it square-ish
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  )
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  item.hint,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
