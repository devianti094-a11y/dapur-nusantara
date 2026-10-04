import 'package:flutter/material.dart';

import '../models/menu_item.dart';
import '../services/menu_service.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/food_card.dart';

import 'about_page.dart';
import 'cart_page.dart';
import 'menu_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  // ==========================================
  // DATA KERANJANG
  // ==========================================

  final List<MenuItem> cartItems = [];

  // ==========================================
  // TAMBAH KE KERANJANG
  // ==========================================

  void tambahKeKeranjang(MenuItem menu) {
    setState(() {
      cartItems.add(menu);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${menu.name} berhasil ditambahkan 🛒',
        ),
        backgroundColor: const Color(0xFFE85D04),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ==========================================
  // BUKA MENU
  // ==========================================

  void bukaMenu() {
    setState(() {
      currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeContent(
        onOpenMenu: bukaMenu,
      ),
      MenuPage(
        onAddToCart: tambahKeKeranjang,
      ),
      CartPage(
        cartItems: cartItems,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

// ======================================================
// HOME CONTENT
// ======================================================

class HomeContent extends StatelessWidget {
  final VoidCallback onOpenMenu;

  const HomeContent({
    super.key,
    required this.onOpenMenu,
  });

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menus = MenuService.getMenu();

    // ==========================================
    // MENU FAVORIT
    // ==========================================

    final List<MenuItem> favoriteMenus = menus.where((menu) {
      return menu.id == '23' ||
          menu.id == '2' ||
          menu.id == '1';
    }).toList();

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          20,
          22,
          20,
          25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // HEADER
            // ==========================================

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Selamat datang 👋',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Halo, Dwi Ajeng!',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // LOGO
                Container(
                  width: 54,
                  height: 54,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFE8D6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.07,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor:
                        Color(0xFFFFE8D6),
                    backgroundImage: AssetImage(
                      'assets/images/logo.jpeg',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 26),

            // ==========================================
            // PROMO BANNER
            // ==========================================

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
                        .withValues(alpha: 0.22),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: 0.18,
                            ),
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '🍴 PROMO HARI INI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Diskon hingga 30%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          'Nikmati makanan favorit dengan harga spesial!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 15),

                        SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: onOpenMenu,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  const Color(0xFFE85D04),
                              elevation: 0,
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Pesan Sekarang',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // ICON DEKORASI
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: 0.13,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ==========================================
            // MENU FAVORIT HEADER
            // ==========================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu Favorit ⭐',
                      style: TextStyle(
                        color: Color(0xFF2D2D2D),
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Pilihan favorit yang wajib dicoba',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                TextButton(
                  onPressed: onOpenMenu,
                  child: const Text(
                    'Lihat semua',
                    style: TextStyle(
                      color: Color(0xFFE85D04),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ==========================================
            // FAVORITE MENU
            // ==========================================

            ...favoriteMenus.map(
              (menu) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: FoodCard(
                  menu: menu,
                  onTap: onOpenMenu,
                  onAdd: null,
                ),
              ),
            ),

            const SizedBox(height: 5),

            // ==========================================
            // TOMBOL SEMUA MENU
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: onOpenMenu,
                icon: const Icon(
                  Icons.restaurant_menu,
                  size: 20,
                ),
                label: const Text(
                  'Lihat Semua Menu',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFE85D04),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ==========================================
            // ABOUT APLIKASI
            // ==========================================

            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const AboutPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.info_outline,
                  size: 18,
                  color: Color(0xFFE85D04),
                ),
                label: const Text(
                  'Tentang Aplikasi',
                  style: TextStyle(
                    color: Color(0xFFE85D04),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            // ==========================================
            // FOOTER
            // ==========================================

            const Center(
              child: Text(
                'Dapur Nusantara • Deviaa Cookingss 🍳',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}