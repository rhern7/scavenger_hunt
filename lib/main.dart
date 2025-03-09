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
          'Usually the first room you see! It was recently being used as an oversized classroom that made everyone uncomfortable.',
      imagePath: 'assets/images/commons.webp',
      answerDetail: 'The Commons!',
    ),
    ScavengerItem(
      hint: 'The only thing that feeds the engineering students. There is no other food available.',
      imagePath: 'assets/images/panera.webp',
      answerDetail: 'Panera. Bring back the energy drinks',
    ),
    ScavengerItem(
      hint:
          'The other room you may see when walking in to PFT. Usually too crowded and used to display sad engineering students to campus tours.',
      imagePath: 'assets/images/atrium.webp',
      answerDetail:
          'The Atrium. Why is it always so hot here',
    ),
    ScavengerItem(
      hint:
          'The most uncomfortable place to sit in the whole building. Seriously, why do people sit here? Just solid wood.',
      imagePath: 'assets/images/wood stairs.jpg',
      answerDetail: 'The weird wooden stairs',
    ),
    ScavengerItem(
      hint:
          'The most prized find in all of PFT. Most people spend at least 30 minutes wandering to find one.',
      imagePath: 'assets/images/seats.webp',
      answerDetail: 'A chair. I just want to sit down man',
    ),
    ScavengerItem(
      hint:
          'The spot where one of the biggest events in PFT history happened. It happens to be right in front of our classroom.',
      imagePath: 'assets/images/flood.webp',
      answerDetail:
          'The great flood',
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
        title: const Text('Welcome to the Scavenger Hunt!'),
        content: const Text(
          'Make it to the end to win nothing!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Called when the user toggles "Mark Found" on an item.
  void _onMarkFound(ScavengerItem item) {
    setState(() {
      // Toggle the found status
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
            title: const Text('Good job!'),
            content: const Text(
              'You made it through the most important areas of PFT!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
            // Decide if this item is active:
            //  - The first item (index 0) is always visible
            //  - Any other item is visible only if the previous item is found
            final bool isActive = (index == 0) || items[index - 1].found;

            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: isActive ? 1.0 : 0.0,
              // Also ignore taps when inactive
              child: AbsorbPointer(
                absorbing: !isActive,
                child: Stack(
                  children: [
                    _buildItemTile(items[index], isActive),
                    // Check mark overlay
                    Positioned(
                      top: 8,
                      right: 8,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: items[index].found ? 1.0 : 0.0,
                        child: const Icon(
                          Icons.check_circle,
                          size: 30,
                          color: Colors.green,
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
