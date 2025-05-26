import 'package:flutter/material.dart';
import '../app_data.dart';

class MyAppsScreen extends StatefulWidget {
  final List<SocialApp> selectedApps;

  const MyAppsScreen({super.key, required this.selectedApps});

  @override
  State<MyAppsScreen> createState() => _MyAppsScreenState();
}

class _MyAppsScreenState extends State<MyAppsScreen> {
  late List<SocialApp> _currentApps;

  @override
  void initState() {
    super.initState();
    _currentApps = List.from(widget.selectedApps);
  }

  void _removeApp(int index) {
    setState(() {
      _currentApps.removeAt(index);
    });
    // You'll need to update the home screen's list too
    // This would require passing a callback or using state management
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background gradients
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(1.3, -1.0),
                radius: 1.5,
                colors: [Color(0xAAAD1457), Colors.transparent],
                stops: [0.1, 1.0],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-1.3, 1.0),
                radius: 1.5,
                colors: [Color(0xAA1A237E), Colors.transparent],
                stops: [0.1, 1.0],
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // Header with back button and title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context, _currentApps); // Return updated list
                      },
                    ),
                    const SizedBox(width: 70),
                    const Text(
                      'My Apps',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Apps list
                Expanded(
                  child: _currentApps.isEmpty
                      ? const Center(
                    child: Text(
                      'No apps selected yet!\nTap the + button to add apps',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18,
                      ),
                    ),
                  )
                      : ListView.separated(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: _currentApps.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.white.withOpacity(0.2),
                      height: 1,
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      final app = _currentApps[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: app.color,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: app.color.withOpacity(0.5),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                app.icon,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          title: Text(
                            app.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () => _removeApp(index),
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.8),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    height: 0.8, // Perfect vertical alignment
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}