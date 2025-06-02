import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialApp {
  final String name;
  final IconData icon;
  final Color color;
  final List<String> launchUrls; // Multiple URL schemes for different platforms
  final String packageName;
  final String fallbackUrl; // Web URL as fallback

  SocialApp({
    required this.name,
    required this.icon,
    required this.color,
    required this.launchUrls,
    required this.packageName,
    required this.fallbackUrl,
  });
}

final List<SocialApp> allSocialApps = [
  // Social Media Platforms
  SocialApp(
    name: 'Facebook',
    icon: FontAwesomeIcons.facebookF,
    color: const Color(0xFF3b5998),
    launchUrls: [
      'fb://', // iOS
      'fb://page', // Android
      'fb://profile', // Alternative
    ],
    packageName: 'com.facebook.katana',
    fallbackUrl: 'https://www.facebook.com',
  ),
  SocialApp(
    name: 'Instagram',
    icon: FontAwesomeIcons.instagram,
    color: const Color(0xFFC13584),
    launchUrls: [
      'instagram://',
      'instagram://user',
      'instagram://app',
    ],
    packageName: 'com.instagram.android',
    fallbackUrl: 'https://www.instagram.com',
  ),
  SocialApp(
    name: 'Twitter',
    icon: FontAwesomeIcons.xTwitter,
    color: const Color(0xFF000000), // Black color (X branding)
    launchUrls: [
      'twitter://',
      'twitter://user?screen_name=',
      'twitter://timeline',
    ],
    packageName: 'com.twitter.android',
    fallbackUrl: 'https://twitter.com',
  ),
  SocialApp(
    name: 'WhatsApp',
    icon: FontAwesomeIcons.whatsapp,
    color: const Color(0xFF25D366),
    launchUrls: [
      'whatsapp://',
      'whatsapp://send',
      'whatsapp://chat',
    ],
    packageName: 'com.whatsapp',
    fallbackUrl: 'https://web.whatsapp.com',
  ),
  SocialApp(
    name: 'YouTube',
    icon: FontAwesomeIcons.youtube,
    color: const Color(0xFFFF0000),
    launchUrls: [
      'youtube://',
      'vnd.youtube://',
      'youtube://channel/',
    ],
    packageName: 'com.google.android.youtube',
    fallbackUrl: 'https://www.youtube.com',
  ),
  SocialApp(
    name: 'TikTok',
    icon: FontAwesomeIcons.tiktok,
    color: const Color(0xFF000000),
    launchUrls: [
      'tiktok://',
      'snssdk1233://',
      'tiktok://user/',
    ],
    packageName: 'com.zhiliaoapp.musically',
    fallbackUrl: 'https://www.tiktok.com',
  ),
  SocialApp(
    name: 'Snapchat',
    icon: FontAwesomeIcons.snapchat,
    color: const Color(0xFFFFFC00),
    launchUrls: [
      'snapchat://',
      'snapchat://add/',
      'snapchat://discover/',
    ],
    packageName: 'com.snapchat.android',
    fallbackUrl: 'https://www.snapchat.com',
  ),
  SocialApp(
    name: 'LinkedIn',
    icon: FontAwesomeIcons.linkedinIn,
    color: const Color(0xFF0077B5),
    launchUrls: [
      'linkedin://',
      'linkedin://profile/',
      'linkedin://company/',
    ],
    packageName: 'com.linkedin.android',
    fallbackUrl: 'https://www.linkedin.com',
  ),
  SocialApp(
    name: 'Pinterest',
    icon: FontAwesomeIcons.pinterest,
    color: const Color(0xFFE60023),
    launchUrls: [
      'pinterest://',
      'pinterest://user/',
      'pinterest://pin/',
    ],
    packageName: 'com.pinterest',
    fallbackUrl: 'https://www.pinterest.com',
  ),
  SocialApp(
    name: 'Reddit',
    icon: FontAwesomeIcons.reddit,
    color: const Color(0xFFFF5700),
    launchUrls: [
      'reddit://',
      'reddit://r/',
      'reddit://user/',
    ],
    packageName: 'com.reddit.frontpage',
    fallbackUrl: 'https://www.reddit.com',
  ),
  SocialApp(
    name: 'Telegram',
    icon: FontAwesomeIcons.telegram,
    color: const Color(0xFF0088CC),
    launchUrls: [
      'tg://',
      'tg://resolve',
      'tg://msg',
    ],
    packageName: 'org.telegram.messenger',
    fallbackUrl: 'https://web.telegram.org',
  ),
  SocialApp(
    name: 'Discord',
    icon: FontAwesomeIcons.discord,
    color: const Color(0xFF5865F2),
    launchUrls: [
      'discord://',
      'discord://channels/',
      'discord://invite/',
    ],
    packageName: 'com.discord',
    fallbackUrl: 'https://discord.com',
  ),
  SocialApp(
    name: 'Spotify',
    icon: FontAwesomeIcons.spotify,
    color: const Color(0xFF1DB954),
    launchUrls: [
      'spotify://',
      'spotify://user/',
      'spotify://track/',
    ],
    packageName: 'com.spotify.music',
    fallbackUrl: 'https://open.spotify.com',
  ),

  SocialApp(
    name: 'Amazon',
    icon: FontAwesomeIcons.amazon,
    color: const Color(0xFFFF9900),
    launchUrls: [
      'amazon://',
      'com.amazon.mobile.shopping://',
      'amzn://',
    ],
    packageName: 'com.amazon.mShop.android.shopping',
    fallbackUrl: 'https://www.amazon.com',
  ),
  SocialApp(
    name: 'PayPal',
    icon: FontAwesomeIcons.paypal,
    color: const Color(0xFF003087),
    launchUrls: [
      'paypal://',
      'com.paypal.android.p2pmobile://',
    ],
    packageName: 'com.paypal.android.p2pmobile',
    fallbackUrl: 'https://www.paypal.com',
  ),
  SocialApp(
    name: 'Zoom',
    icon: FontAwesomeIcons.video,
    color: const Color(0xFF2D8CFF),
    launchUrls: [
      'zoomus://',
      'zoommtg://',
      'zoomus://',
    ],
    packageName: 'us.zoom.videomeetings',
    fallbackUrl: 'https://zoom.us',
  ),
  SocialApp(
    name: 'Google Maps',
    icon: FontAwesomeIcons.map,
    color: const Color(0xFF4285F4),
    launchUrls: [
      'googlemaps://',
      'comgooglemaps://',
      'comgooglemapsurl://',
    ],
    packageName: 'com.google.android.apps.maps',
    fallbackUrl: 'https://maps.google.com',
  ),
  SocialApp(
    name: 'Gmail',
    icon: FontAwesomeIcons.envelope,
    color: const Color(0xFFEA4335),
    launchUrls: [
      'googlegmail://',
      'googlemail://',
      'com.google.gmail://',
    ],
    packageName: 'com.google.android.gm',
    fallbackUrl: 'https://mail.google.com',
  ),
  SocialApp(
    name: 'Google Drive',
    icon: FontAwesomeIcons.googleDrive,
    color: const Color(0xFF34A853),
    launchUrls: [
      'googledrive://',
      'com.google.android.apps.docs://',
    ],
    packageName: 'com.google.android.apps.docs',
    fallbackUrl: 'https://drive.google.com',
  ),
];