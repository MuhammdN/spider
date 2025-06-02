import 'package:flutter/material.dart';
import 'package:spider/settings_screen.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'add_app_screen.dart';
import 'login_screen.dart';
import 'notifications_page.dart';
import 'social_app_screen.dart';
import 'dart:math';
import '../app_data.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<bool> _authenticateUser(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
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

  Future<void> _launchApp(SocialApp app) async {
    bool launched = false;

    // Try all possible URL schemes
    for (String url in app.launchUrls) {
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
          launched = true;
          break;
        }
      } catch (e) {
        debugPrint('Failed to launch with $url: $e');
      }
    }

    if (!launched) {
      // Try deep linking for Android
      if (Theme.of(context).platform == TargetPlatform.android) {
        try {
          final intent = AndroidIntent(
            action: 'action_view',
            package: app.packageName,
          );
          await intent.launch();
          launched = true;
        } catch (e) {
          debugPrint('Android intent failed: $e');
        }
      }

      // Fallback to web URL
      if (!launched) {
        if (await canLaunchUrl(Uri.parse(app.fallbackUrl))) {
          await launchUrl(Uri.parse(app.fallbackUrl));
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not launch ${app.name}')),
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/home/Vector.png',
              fit: BoxFit.cover,
            ),
          ),

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

          Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // In the build method of _HomeScreenState, replace the welcome text:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${UserSession.userName ?? "User"}',
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

      // Adjust positions for better visual alignment
      switch (index) {
        case 0: x -= 55; y -= 90; break;
        case 1: x += 5; y -= 14; break;
        case 2: x += 45; y -= 20; break;
        case 3: x += 35; y += 10; break;
        case 4: x += 33; y += 60; break;
        case 5: x += 35; break;
        case 6: x -= 18; y += 2; break;
        case 7: x -= 55; y -= 30; break;
      }

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
                  await _launchApp(app);
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