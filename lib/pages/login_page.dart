import 'dart:ui';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/custom_button.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    animationController.forward();
  }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password wajib diisi!'),
          backgroundColor: Color(0xFFE85D04),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    AuthService.login(email, password);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // =====================================
          // WALLPAPER FULL SCREEN
          // =====================================

          Positioned.fill(
            child: Image.asset(
              'assets/images/login_wallpaper dapur nusantara.jpeg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFFFF8F2),
                );
              },
            ),
          ),

          // =====================================
          // DARK OVERLAY
          // =====================================

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),
          ),

          // =====================================
          // CONTENT
          // =====================================

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // =====================================
                        // LOGO
                        // =====================================

                        Container(
                          width: 105,
                          height: 105,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(
                              alpha: 0.92,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFB703)
                                    .withValues(alpha: 0.55),
                                blurRadius: 28,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // =====================================
                        // NAMA RESTORAN
                        // =====================================

                        const Text(
                          'Dapur Nusantara',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black87,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          'Deviaa Cookingss 🍳✨',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.8,
                            shadows: [
                              Shadow(
                                color: Colors.black87,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Pesan makanan favoritmu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            shadows: [
                              Shadow(
                                color: Colors.black87,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        // =====================================
                        // FORM GLASS CARD
                        // =====================================

                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 14,
                              sigmaY: 14,
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(
                                  alpha: 0.25,
                                ),
                                borderRadius:
                                    BorderRadius.circular(28),
                                border: Border.all(
                                  color: Colors.white.withValues(
                                    alpha: 0.55,
                                  ),
                                  width: 1.3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(
                                      alpha: 0.20,
                                    ),
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // =====================================
                                  // JUDUL LOGIN
                                  // =====================================

                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Selamat Datang 👋',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black54,
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Silakan masuk untuk melanjutkan',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black54,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 22),

                                  // =====================================
                                  // EMAIL
                                  // =====================================

                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 7),

                                  TextField(
                                    controller: emailController,
                                    keyboardType:
                                        TextInputType.emailAddress,
                                    style: const TextStyle(
                                      color: Color(0xFF333333),
                                    ),
                                    decoration: InputDecoration(
                                      hintText:
                                          'Masukkan email kamu',
                                      hintStyle:
                                          const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: Color(0xFFE85D04),
                                      ),
                                      filled: true,
                                      fillColor:
                                          Colors.white.withValues(
                                        alpha: 0.92,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide.none,
                                      ),
                                      focusedBorder:
                                          OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        borderSide:
                                            const BorderSide(
                                          color:
                                              Color(0xFFE85D04),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  // =====================================
                                  // PASSWORD
                                  // =====================================

                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 7),

                                  TextField(
                                    controller:
                                        passwordController,
                                    obscureText: hidePassword,
                                    style: const TextStyle(
                                      color: Color(0xFF333333),
                                    ),
                                    decoration: InputDecoration(
                                      hintText:
                                          'Masukkan password kamu',
                                      hintStyle:
                                          const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Color(0xFFE85D04),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            hidePassword =
                                                !hidePassword;
                                          });
                                        },
                                        icon: Icon(
                                          hidePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor:
                                          Colors.white.withValues(
                                        alpha: 0.92,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide.none,
                                      ),
                                      focusedBorder:
                                          OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        borderSide:
                                            const BorderSide(
                                          color:
                                              Color(0xFFE85D04),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 22),

                                  // =====================================
                                  // TOMBOL MASUK
                                  // =====================================

                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomButton(
                                      text: 'Masuk',
                                      icon: Icons.login,
                                      onPressed: login,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // =====================================
                        // FOOTER
                        // =====================================

                        const Text(
                          '🍽️ Nikmati cita rasa Nusantara',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                color: Colors.black87,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}