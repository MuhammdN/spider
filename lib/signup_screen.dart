import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/splash/image 1-2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Top Pink Glow
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

          // Bottom Blue Glow
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

          // Diagonal Shadow
          Center(
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 300,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 60,
                      spreadRadius: 40,
                      offset: const Offset(40, 40),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main Signup UI
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Image.asset('assets/splash/Group 1410092262.png', height: 100),
                    const SizedBox(height: 50),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),

                            // Centered "Already have an account?"
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account? "),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: ShaderMask(
                                    shaderCallback: (bounds) => const LinearGradient(
                                      colors: [Colors.orange, Colors.pink],
                                    ).createShader(bounds),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                            const TextField(decoration: InputDecoration(labelText: 'Full Name')),
                            const SizedBox(height: 10),
                            const TextField(decoration: InputDecoration(labelText: 'Email')),
                            const SizedBox(height: 10),

                            // Password Field with Show/Hide
                            TextField(
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Register Button
                            GestureDetector(
                              onTap: () {
                                // Navigate to login after registration
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                    colors: [Colors.orange, Colors.pink],
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
