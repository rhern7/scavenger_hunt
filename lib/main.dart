import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define an LSU-inspired color scheme.
    final ColorScheme lsuColorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF46166B),   // LSU Purple
      onPrimary: Colors.white,
      secondary: Color(0xFFFDB927), // LSU Gold
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    );

    return MaterialApp(
      title: 'LSU Campus Scavenger Hunt',
      theme: ThemeData(
        colorScheme: lsuColorScheme,
        // Optionally, you might set a fontFamily here if the LSU guide specifies one.
        // fontFamily: 'Georgia', // example font
      ),
      home: const ScavengerHomePage(title: 'LSU Scavenger Home'),
    );
  }
}

/// A single scavenger-hunt item containing:
///  - hint: a riddle or clue about the location
///  - imagePath: path to its reveal image
///  - answerDetail: a short message displayed when revealed
///  - found: whether the item has been marked as found
class ScavengerItem {
  final String hint;
  final String imagePath;
  final String answerDetail;
  bool found;

  ScavengerItem({
    required this.hint,
    required this.imagePath,
    required this.answerDetail,
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
  final List<ScavengerItem> items = [
    ScavengerItem(
      hint:
          'Usually the first room you see! It was recently used as an oversized classroom that felt inviting.',
      imagePath: 'assets/images/commons.webp',
      answerDetail: 'The Commons!',
    ),
    ScavengerItem(
      hint: 'The only spot that fuels our engineering Tigers. No other food can compare.',
      imagePath: 'assets/images/panera.webp',
      answerDetail: 'Panera. A true LSU fuel stop!',
    ),
    ScavengerItem(
      hint:
          'Another space encountered when entering PFT. Often buzzing with LSU pride and campus life.',
      imagePath: 'assets/images/atrium.webp',
      answerDetail: 'The Atrium. A hub of energy!',
    ),
    ScavengerItem(
      hint:
          'A classic area with a touch of tradition. Where every seat has a story.',
      imagePath: 'assets/images/wood stairs.jpg',
      answerDetail: 'The iconic wooden stairs',
    ),
    ScavengerItem(
      hint:
          'A coveted find in PFT—many spend minutes in search of this hidden treasure.',
      imagePath: 'assets/images/seats.webp',
      answerDetail: 'A cherished seat. Time to relax!',
    ),
    ScavengerItem(
      hint:
          'The site of a memorable campus moment, right in front of our classroom.',
      imagePath: 'assets/images/flood.webp',
      answerDetail: 'A historic moment on LSU grounds',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Show the welcome message once the app starts.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
    });
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Welcome to the LSU Campus Scavenger Hunt!'),
        content: const Text(
          'Explore our beautiful campus and uncover hidden treasures!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Let\'s Go'),
          ),
        ],
      ),
    );
  }

  /// Called when the user toggles "Mark Found" on an item.
  void _onMarkFound(ScavengerItem item) {
    setState(() {
      item.found = !item.found;
    });

    if (item.found) {
      // Minor celebratory feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Found: "${item.hint}"'),
          duration: const Duration(seconds: 1),
        ),
      );

      // Check if all items are found
      if (items.every((element) => element.found)) {
        // Show final message
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Geaux Tigers!'),
            content: const Text(
              'You have discovered all the key areas of our LSU campus!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Celebrate'),
              ),
            ],
          ),
        );
      }
    }
  }

  /// Called when the user taps "Reveal," showing a dialog with the item's image
  /// and its unique message.
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
                // Make the word "Answer" bigger
                Text(
                  'Answer',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Show the item image
                Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                  height: 200,
                ),
                const SizedBox(height: 16),
                // Unique message describing the answer
                Text(
                  item.answerDetail,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
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

  /// Builds a single "tile" in the grid.
  Widget _buildItemTile(ScavengerItem item, bool isActive) {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Make the tile hint bigger
          Expanded(
            child: Center(
              child: Text(
                item.hint,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: isActive ? () => _onMarkFound(item) : null,
                child: Text(item.found ? 'Unmark' : 'Mark Found'),
              ),
              ElevatedButton(
                onPressed: isActive ? () => _onRevealAnswer(item) : null,
                child: const Text('Reveal'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // Use LSU Purple for the AppBar background.
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns for smaller squares
            childAspectRatio: 1.0,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            // The first item (index 0) is always active;
            // any other item is active only if the previous one is found.
            final bool isActive = (index == 0) || items[index - 1].found;

            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: isActive ? 1.0 : 0.0,
              child: AbsorbPointer(
                absorbing: !isActive,
                child: Stack(
                  children: [
                    _buildItemTile(items[index], isActive),
                    // Check mark overlay now uses LSU Gold.
                    Positioned(
                      top: 8,
                      right: 8,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: items[index].found ? 1.0 : 0.0,
                        child: Icon(
                          Icons.check_circle,
                          size: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
