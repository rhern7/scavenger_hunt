import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Scavenger Hunt',
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
//replace with real pictures and hints
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

  void _onMarkFound(ScavengerItem item) {
    setState(() {
      item.found = !item.found;
    });
    if (item.found) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Found: "${item.hint}"'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _onRevealAnswer(ScavengerItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 32,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Answer',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                  height: 200,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemTile(ScavengerItem item) {
    return Stack(
      children: [
        // Main box
        Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    item.hint,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _onMarkFound(item),
                    child: Text(item.found ? 'Unmark' : 'Mark Found'),
                  ),
                  ElevatedButton(
                    onPressed: () => _onRevealAnswer(item),
                    child: const Text('Reveal'),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Check mark overlay
        Positioned(
          top: 8,
          right: 8,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: item.found ? 1.0 : 0.0,
            child: const Icon(
              Icons.check_circle,
              size: 30,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return _buildItemTile(items[index]);
          },
        ),
      ),
    );
  }
}
