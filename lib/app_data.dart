import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SocialApp {
  final String name;
  final IconData icon;
  final Color color;

  SocialApp({required this.name, required this.icon, required this.color});
}

final List<SocialApp> allSocialApps = [
  SocialApp(name: 'Facebook', color: Color(0xFF3b5998), icon: FontAwesomeIcons.facebookF),
  SocialApp(name: 'Instagram', color: Color(0xFFC13584), icon: FontAwesomeIcons.instagram),
  SocialApp(name: 'X', color: Colors.black, icon: FontAwesomeIcons.xTwitter),
  SocialApp(name: 'WhatsApp', color: Color(0xFF25D366), icon: FontAwesomeIcons.whatsapp),
  SocialApp(name: 'Snapchat', color: Color(0xFFFFFC00), icon: FontAwesomeIcons.snapchatGhost),
  SocialApp(name: 'LinkedIn', color: Color(0xFF0077B5), icon: FontAwesomeIcons.linkedinIn),
  SocialApp(name: 'YouTube', color: Color(0xFFFF0000), icon: FontAwesomeIcons.youtube),
  SocialApp(name: 'Telegram', color: Color(0xFF0088cc), icon: FontAwesomeIcons.telegram),
  SocialApp(name: 'Pinterest', color: Color(0xFFE60023), icon: FontAwesomeIcons.pinterest),
  SocialApp(name: 'Reddit', color: Color(0xFFFF5700), icon: FontAwesomeIcons.redditAlien),

];
