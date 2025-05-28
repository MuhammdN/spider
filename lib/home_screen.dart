import 'package:flutter/material.dart';
import 'package:spider/settings_screen.dart';
import 'add_app_screen.dart';
import 'notifications_page.dart';
import 'social_app_screen.dart';
import 'dart:math';
import '../app_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SocialApp> selectedApps = [];
  final List<Color> legColors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.lightBlueAccent,
    Colors.pink,
    Colors.orange,
    Colors.purple,
    Colors.green,
  ];

  // Login function that can be reused
  Future<bool> _authenticateUser(String email, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Basic validation - in real app, this would call your authentication API
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> _showLoginDialog(BuildContext context, String appName) async {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool obscurePassword = true;
    bool isLoading = false;
    String? errorMessage;

    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Login to $appName',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Error message if any
                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    // Email field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // Password field with visibility toggle
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: isLoading ? null : () async {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            setState(() {
                              errorMessage = 'Please enter both email and password';
                            });
                            return;
                          }

                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });

                          final isAuthenticated = await _authenticateUser(
                            emailController.text,
                            passwordController.text,
                          );

                          if (isAuthenticated) {
                            Navigator.of(context).pop(true);
                          } else {
                            setState(() {
                              isLoading = false;
                              errorMessage = 'Invalid credentials. Please try again.';
                            });
                          }
                        },
                        child: isLoading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                            : const Text(
                          'LOG IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/home/Vector.png',
              fit: BoxFit.cover,
            ),
          ),

          // Background gradients
          Container(
            width: double.infinity,
            height: double.infinity,
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
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-1.3, 1.0),
                radius: 1.5,
                colors: [Color(0xAA1A237E), Colors.transparent],
                stops: [0.1, 1.0],
              ),
            ),
          ),

          // Header section
          Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Welcome, John',
                          style: TextStyle(fontSize: 22, color: Colors.white70),
                        ),
                        Text(
                          'Digital web is ready',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white70),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Main spider web with icons
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Image.asset(
                      'assets/home/Vector (1).png',
                      width: 350,
                      height: 350,
                    ),
                  ),
                  ..._buildSpiderLegsWithIcons(),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating action button for adding apps
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push<List<SocialApp>>(
            context,
            MaterialPageRoute(
              builder: (_) => AddAppsScreen(initialSelectedApps: selectedApps),
            ),
          ).then((result) {
            if (result != null) {
              setState(() {
                selectedApps = result;
              });
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: const Color(0xFF1B1B3A),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: null,
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(selectedApps: selectedApps),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSpiderLegsWithIcons() {
    const double radius = 120;
    const double centerX = 150;
    const double centerY = 150;

    return List.generate(8, (index) {
      double angle = (2 * pi / 8) * index;
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);

      // Position adjustments for each leg
      if (index == 6) { x -= 18; y -= -2; }
      else if (index == 2) { x += 45; y -= 20; }
      else if (index == 1) { x += 5; y -= 14; }
      else if (index == 5) { x += 35; }
      else if (index == 3) { x += 35; y += 10; }
      else if (index == 4) { x += 33; y += 60; }
      else if (index == 7) { x -= 55; y -= 30; }
      else if (index == 0) { x -= 55; y -= 90; }

      if (index < selectedApps.length) {
        final app = selectedApps[index];
        return Positioned(
          left: x - 20,
          top: y - 20,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                debugPrint('Tapped ${app.name}');
                final shouldProceed = await _showLoginDialog(context, app.name);
                if (shouldProceed && mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SocialAppScreen(appName: app.name),
                    ),
                  );
                }
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: app.color.withOpacity(0.6),
                  boxShadow: [
                    BoxShadow(
                      color: app.color.withOpacity(0.8),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(app.icon, color: Colors.white, size: 25),
                ),
              ),
            ),
          ),
        );
      } else {
        return Positioned(
          left: x - 20,
          top: y - 20,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: legColors[index].withOpacity(0.4),
              boxShadow: [
                BoxShadow(
                  color: legColors[index].withOpacity(0.7),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '+',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: legColors[index], blurRadius: 15),
                    Shadow(color: legColors[index].withOpacity(0.5), blurRadius: 25),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}