import 'package:flutter/material.dart';
import '../app_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddAppsScreen extends StatefulWidget {
  final List<SocialApp> initialSelectedApps;

  const AddAppsScreen({Key? key, required this.initialSelectedApps}) : super(key: key);

  @override
  State<AddAppsScreen> createState() => _AddAppsScreenState();
}

class _AddAppsScreenState extends State<AddAppsScreen> {
  late List<SocialApp> selectedApps;

  @override
  void initState() {
    super.initState();
    selectedApps = List.from(widget.initialSelectedApps);
  }

  bool _isSelected(SocialApp app) => selectedApps.any((a) => a.name == app.name);

  void showHideHelpDialog(BuildContext context, String appName) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final instructions = isIOS
        ? "1. Long-press the app icon on your home screen.\n"
        "2. Tap 'Remove App'.\n"
        "3. Select 'Remove from Home Screen' (not Delete)."
        : "1. Long-press the app icon on your home screen.\n"
        "2. Tap 'Remove from Home Screen' or 'Hide App'.";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Hide $appName App"),
        content: Text(
          "You've added $appName to your wallet.\n\n"
              "To hide the original app from your phone manually:\n\n$instructions",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Got it"),
          ),
        ],
      ),
    );
  }

  void _toggleAppSelection(SocialApp app) {
    setState(() {
      if (_isSelected(app)) {
        selectedApps.removeWhere((a) => a.name == app.name);
      } else {
        if (selectedApps.length < 8) {
          selectedApps.add(app);
          showHideHelpDialog(context, app.name);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Maximum 8 apps allowed'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/splash/image 1-1.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

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

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context, selectedApps),
                      ),
                      const Text(
                        'Select Apps',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.white),
                        onPressed: () => Navigator.pop(context, selectedApps),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '${selectedApps.length} of 8 selected',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: allSocialApps.length,
                    itemBuilder: (context, index) {
                      final app = allSocialApps[index];
                      final isSelected = _isSelected(app);

                      return Card(
                        color: Colors.white.withOpacity(0.1),
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected ? app.color : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: app.color.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: app.color,
                                width: 2,
                              ),
                            ),
                            child: Icon(app.icon, color: Colors.white),
                          ),
                          title: Text(
                            app.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Checkbox(
                            value: isSelected,
                            onChanged: (value) => _toggleAppSelection(app),
                            activeColor: app.color,
                            shape: CircleBorder(),
                          ),
                          onTap: () => _toggleAppSelection(app),
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