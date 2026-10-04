import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            20,
            22,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // HEADER
              // ==================================================

              const Text(
                'Profil 👤',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Informasi profil dan akun kamu',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // PROFILE CARD
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE85D04),
                      Color(0xFFF48C06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE85D04)
                          .withValues(alpha: 0.20),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // FOTO PROFIL
                    Container(
                      width: 115,
                      height: 115,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: 0.12,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/devia.jpeg',
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFFFE8D6),
                              child: const Icon(
                                Icons.person,
                                size: 58,
                                color: Color(0xFFE85D04),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // NAMA
                    const Text(
                      'Dwi Ajeng Fadhilah Devianti',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 7),

                    // TAGLINE
                    const Text(
                      '✨ Tech Enthusiast • Creative Learner',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // EMAIL / STATUS
                    Text(
                      user?.email ??
                          'Mahasiswa Teknik Informatika',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ==================================================
              // DATA DIRI
              // ==================================================

              const Text(
                'Data Diri',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Informasi dasar profil',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 13),

              _infoCard(
                icon: Icons.person_outline,
                title: 'Nama',
                value: 'Dwi Ajeng Fadhilah Devianti',
              ),

              const SizedBox(height: 10),

              _infoCard(
                icon: Icons.school_outlined,
                title: 'Program Studi',
                value: 'Teknik Informatika - UNESA',
              ),

              const SizedBox(height: 10),

              _infoCard(
                icon: Icons.badge_outlined,
                title: 'NIM',
                value: '25051204420',
              ),

              const SizedBox(height: 24),

              // ==================================================
              // TENTANG SAYA
              // ==================================================

              const Text(
                'Tentang Saya',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Sedikit cerita tentang saya',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 13),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.04,
                      ),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Halo! Saya Dwi Ajeng Fadhilah Devianti, '
                  'mahasiswa Program Studi Teknik Informatika '
                  'Universitas Negeri Surabaya. Saya memiliki '
                  'ketertarikan pada bidang teknologi, khususnya '
                  'pengembangan aplikasi dan desain antarmuka. '
                  'Saya senang mempelajari hal-hal baru, mampu '
                  'bekerja sama dalam tim, serta terus berusaha '
                  'mengembangkan kemampuan di bidang teknologi '
                  'informasi.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.7,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ==================================================
              // MEDIA SOSIAL
              // ==================================================

              const Text(
                'Media Sosial',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Temukan saya di media sosial',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 13),

              Row(
                children: [
                  Expanded(
                    child: _socialCard(
                      icon: Icons.music_note,
                      title: 'TikTok',
                      username: '@4fdhllh',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _socialCard(
                      icon: Icons.camera_alt_outlined,
                      title: 'Instagram',
                      username: '@dviiantt',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ==================================================
              // LOGOUT
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFFE85D04),
                  ),
                  label: const Text(
                    'Keluar dari Akun',
                    style: TextStyle(
                      color: Color(0xFFE85D04),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFFFC7A3),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // FOOTER
              // ==================================================

              Center(
                child: Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFE8D6),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo.jpeg',
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) {
                            return const Icon(
                              Icons.restaurant,
                              color: Color(0xFFE85D04),
                              size: 26,
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Dapur Nusantara',
                      style: TextStyle(
                        color: Color(0xFFE85D04),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      'Deviaa Cookingss 🍳',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // INFO CARD
  // ==========================================================

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE8D6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFE85D04),
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SOCIAL CARD
  // ==========================================================

  Widget _socialCard({
    required IconData icon,
    required String title,
    required String username,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE8D6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFE85D04),
              size: 20,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            username,
            style: const TextStyle(
              color: Color(0xFFE85D04),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // LOGOUT DIALOG
  // ==========================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Keluar dari akun?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Kamu akan kembali ke halaman login.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AuthService.logout();

                Navigator.pop(dialogContext);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE85D04),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}