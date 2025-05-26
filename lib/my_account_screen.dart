import 'package:flutter/material.dart';

import 'EditAccountScreen.dart';


class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Pink Glow Top Right
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(1.3, -1.0),
                radius: 1.5,
                colors: [
                  Color(0xAAAD1457),
                  Colors.transparent,
                ],
                stops: [0.1, 1.0],
              ),
            ),
          ),
          // Blue Glow Bottom Left
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-1.3, 1.0),
                radius: 1.5,
                colors: [
                  Color(0xAA1A237E),
                  Colors.transparent,
                ],
                stops: [0.1, 1.0],
              ),
            ),
          ),
          // Black Diagonal Shadow
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

          // UI Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                    ),
                    const Text(
                      "My Account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                const _InfoRow(label: "Name", value: "Lois Becket"),
                const Divider(color: Colors.white24, thickness: 1, indent: 20, endIndent: 20),

                const _InfoRow(label: "Email Address", value: "info@lois.com"),
                const Divider(color: Colors.white24, thickness: 1, indent: 20, endIndent: 20),

                const _InfoRow(label: "Password", value: "rtyfghab1980"),
                const Divider(color: Colors.white24, thickness: 1, indent: 20, endIndent: 20),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),

      // Here is the floating button with your gradient style preserved
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditAccountScreen()),
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Color(0xFFFF5B5B), Color(0xFFAC30F4)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              "Edit Account",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
