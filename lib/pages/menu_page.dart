import 'package:flutter/material.dart';

import '../models/menu_item.dart';
import '../services/menu_service.dart';
import '../widgets/food_card.dart';

class MenuPage extends StatefulWidget {
  final Function(MenuItem) onAddToCart;

  const MenuPage({
    super.key,
    required this.onAddToCart,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedCategory = 'Semua';
  String searchQuery = '';

  final TextEditingController searchController =
      TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menus = MenuService.getMenu();

    // ==========================================
    // FILTER KATEGORI + SEARCH
    // ==========================================

    final filteredMenus = menus.where((menu) {
      final categoryMatch =
          selectedCategory == 'Semua' ||
          menu.category == selectedCategory;

      final searchMatch =
          menu.name.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ||
          menu.description.toLowerCase().contains(
                searchQuery.toLowerCase(),
              );

      return categoryMatch && searchMatch;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // HEADER
            // ==========================================

            const Text(
              'Menu 🍽️',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Temukan makanan favoritmu di sini',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 18),

            // ==========================================
            // SEARCH BAR
            // ==========================================

            Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.05,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText:
                      'Cari makanan, minuman, dessert...',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFE85D04),
                  ),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            searchController.clear();

                            setState(() {
                              searchQuery = '';
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFFE85D04),
                      width: 1.5,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ==========================================
            // KATEGORI
            // ==========================================

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics:
                  const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _categoryButton(
                    'Semua',
                    Icons.restaurant_menu,
                  ),
                  const SizedBox(width: 9),
                  _categoryButton(
                    'Makanan',
                    Icons.fastfood,
                  ),
                  const SizedBox(width: 9),
                  _categoryButton(
                    'Minuman',
                    Icons.local_drink,
                  ),
                  const SizedBox(width: 9),
                  _categoryButton(
                    'Dessert',
                    Icons.icecream,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================
            // INFO HASIL
            // ==========================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredMenus.length} menu tersedia',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666666),
                  ),
                ),

                if (searchQuery.isNotEmpty)
                  Text(
                    'Hasil pencarian',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFE85D04),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            // ==========================================
            // LIST MENU
            // ==========================================

            Expanded(
              child: filteredMenus.isEmpty
                  ? _emptyState()
                  : ListView.builder(
                      physics:
                          const BouncingScrollPhysics(),
                      padding:
                          const EdgeInsets.only(
                        bottom: 20,
                      ),
                      itemCount:
                          filteredMenus.length,
                      itemBuilder:
                          (context, index) {
                        final menu =
                            filteredMenus[index];

                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 2,
                          ),
                          child: FoodCard(
                            menu: menu,
                            onTap: () {},
                            onAdd: () {
                              widget.onAddToCart(
                                menu,
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // CATEGORY BUTTON
  // ==========================================

  Widget _categoryButton(
    String category,
    IconData icon,
  ) {
    final bool isSelected =
        selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE85D04)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFE85D04)
                : const Color(0xFFFFE8D6),
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFFE85D04)
                    .withValues(alpha: 0.18),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: isSelected
                  ? Colors.white
                  : const Color(0xFFE85D04),
            ),
            const SizedBox(width: 7),
            Text(
              category,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.white
                    : const Color(0xFFE85D04),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // EMPTY STATE
  // ==========================================

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE8D6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off,
              size: 42,
              color: Color(0xFFE85D04),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Menu tidak ditemukan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Coba cari menu atau kategori lainnya.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}