import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dapur Nusantara',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE85D04),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F2),
      ),
      home: const LoginPage(),
    );
  }
}