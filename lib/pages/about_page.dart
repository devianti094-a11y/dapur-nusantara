import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const Color primary = Color(0xFFE85D04);
  static const Color lightOrange = Color(0xFFFFE8D6);
  static const Color background = Color(0xFFF8F5F2);
  static const Color darkText = Color(0xFF2D2D2D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'About Me',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
        child: Column(
          children: [

            // =====================================================
            // PROFILE HEADER
            // =====================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFE8D6),
                    Color(0xFFFFF8F2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 18,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Column(
                children: [

                  // =========================
                  // FOTO PROFIL
                  // =========================
                  Container(
                    width: 145,
                    height: 145,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primary,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/devia.jpeg',
                        width: 145,
                        height: 145,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: lightOrange,
                            child: const Icon(
                              Icons.person,
                              size: 75,
                              color: primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =========================
                  // NAMA
                  // =========================
                  const Text(
                    'Dwi Ajeng Fadhilah Devianti',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 7),

                  // =========================
                  // ROLE
                  // =========================
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Mahasiswa Teknik Informatika',
                      style: TextStyle(
                        color: primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =========================
                  // SOCIAL MEDIA
                  // =========================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      _socialButton(
                        icon: Icons.camera_alt_outlined,
                        label: '@dviiantt',
                      ),

                      const SizedBox(width: 10),

                      _socialButton(
                        icon: Icons.music_note,
                        label: '@4fdhllh',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // =====================================================
            // INFORMASI PRIBADI
            // =====================================================
            _sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  _sectionTitle(
                    icon: Icons.person_outline,
                    title: 'Informasi Pribadi',
                  ),

                  const SizedBox(height: 18),

                  _infoItem(
                    icon: Icons.badge_outlined,
                    title: 'NIM',
                    value: '25051204420',
                  ),

                  const SizedBox(height: 11),

                  _infoItem(
                    icon: Icons.computer_outlined,
                    title: 'Program Studi',
                    value: 'Teknik Informatika',
                  ),

                  const SizedBox(height: 11),

                  _infoItem(
                    icon: Icons.school_outlined,
                    title: 'Universitas',
                    value: 'Universitas Negeri Surabaya',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // =====================================================
            // TENTANG APLIKASI
            // =====================================================
            _sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  _sectionTitle(
                    icon: Icons.restaurant_menu,
                    title: 'Tentang Aplikasi',
                  ),

                  const SizedBox(height: 18),

                  // =========================
                  // LOGO DAPUR NUSANTARA
                  // =========================
                  Center(
                    child: Container(
                      width: 115,
                      height: 115,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: lightOrange,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets//images/logo.jpeg',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.restaurant,
                              color: primary,
                              size: 55,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Center(
                    child: Text(
                      'Dapur Nusantara',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Center(
                    child: Text(
                      'deviaa cookingss',
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Dapur Nusantara merupakan aplikasi pemesanan '
                    'makanan berbasis Flutter yang menghadirkan berbagai '
                    'pilihan makanan, minuman, dan dessert khas Nusantara.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Color(0xFF555555),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Aplikasi ini dirancang dengan tampilan yang sederhana, '
                    'modern, dan mudah digunakan untuk memberikan pengalaman '
                    'menjelajahi menu makanan yang lebih nyaman.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // =====================================================
            // FITUR APLIKASI
            // =====================================================
            _sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  _sectionTitle(
                    icon: Icons.auto_awesome,
                    title: 'Fitur Aplikasi',
                  ),

                  const SizedBox(height: 18),

                  _featureItem(
                    icon: Icons.restaurant,
                    title: 'Daftar Menu',
                    description:
                        'Melihat berbagai pilihan makanan dan minuman.',
                  ),

                  const SizedBox(height: 15),

                  _featureItem(
                    icon: Icons.favorite,
                    title: 'Menu Favorit',
                    description:
                        'Menampilkan menu pilihan yang direkomendasikan.',
                  ),

                  const SizedBox(height: 15),

                  _featureItem(
                    icon: Icons.shopping_cart_outlined,
                    title: 'Keranjang',
                    description:
                        'Menambahkan makanan atau minuman yang ingin dipesan.',
                  ),

                  const SizedBox(height: 15),

                  _featureItem(
                    icon: Icons.person_outline,
                    title: 'Profile',
                    description:
                        'Menampilkan informasi pembuat aplikasi.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // =====================================================
            // FOOTER
            // =====================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  const Icon(
                    Icons.restaurant_menu,
                    color: primary,
                    size: 28,
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Dapur Nusantara',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    '© 2026 Dapur Nusantara',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Made with Flutter ❤️',
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // SECTION CARD
  // =============================================================
  static Widget _sectionCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  // =============================================================
  // SECTION TITLE
  // =============================================================
  static Widget _sectionTitle({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [

        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: lightOrange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: primary,
            size: 23,
          ),
        ),

        const SizedBox(width: 12),

        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),
      ],
    );
  }

  // =============================================================
  // SOCIAL BUTTON
  // =============================================================
  static Widget _socialButton({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            color: primary,
            size: 17,
          ),

          const SizedBox(width: 6),

          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF555555),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // INFO ITEM
  // =============================================================
  static Widget _infoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: lightOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: primary,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // FEATURE ITEM
  // =============================================================
  static Widget _featureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: lightOrange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: primary,
            size: 22,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
