import 'package:flutter/material.dart';

import '../models/menu_item.dart';

class CartPage extends StatefulWidget {
  final List<MenuItem> cartItems;

  const CartPage({
    super.key,
    required this.cartItems,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // ======================================================
  // CONTROLLER
  // ======================================================

  final TextEditingController catatanController =
      TextEditingController();

  // ======================================================
  // STATUS PESANAN
  // ======================================================

  bool orderCompleted = false;
  int lastOrderTotal = 0;
  int lastOrderItems = 0;

  // Nomor pesanan sederhana untuk tampilan aplikasi.
  String orderNumber = '';

  @override
  void dispose() {
    catatanController.dispose();
    super.dispose();
  }

  // ======================================================
  // FORMAT RUPIAH
  // ======================================================

  String formatRupiah(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }

  // ======================================================
  // JUMLAH ITEM
  // ======================================================

  Map<String, int> get itemQuantities {
    final Map<String, int> quantities = {};

    for (final menu in widget.cartItems) {
      quantities[menu.id] =
          (quantities[menu.id] ?? 0) + 1;
    }

    return quantities;
  }

  // ======================================================
  // ITEM UNIK
  // ======================================================

  List<MenuItem> get uniqueItems {
    final Map<String, MenuItem> unique = {};

    for (final menu in widget.cartItems) {
      unique[menu.id] = menu;
    }

    return unique.values.toList();
  }

  // ======================================================
  // TOTAL
  // ======================================================

  int get totalHarga {
    int total = 0;

    for (final menu in widget.cartItems) {
      total += menu.price;
    }

    return total;
  }

  // ======================================================
  // TAMBAH QUANTITY
  // ======================================================

  void tambahQuantity(MenuItem menu) {
    setState(() {
      widget.cartItems.add(menu);
    });
  }

  // ======================================================
  // KURANGI QUANTITY
  // ======================================================

  void kurangiQuantity(MenuItem menu) {
    final index = widget.cartItems.indexWhere(
      (item) => item.id == menu.id,
    );

    if (index == -1) return;

    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  // ======================================================
  // HAPUS ITEM
  // ======================================================

  void hapusItem(MenuItem menu) {
    setState(() {
      widget.cartItems.removeWhere(
        (item) => item.id == menu.id,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${menu.name} dihapus dari keranjang',
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

  // ======================================================
  // CHECKOUT
  // ======================================================

  void checkout() {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Keranjang masih kosong!',
          ),
          backgroundColor: Color(0xFFE85D04),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    final catatan =
        catatanController.text.trim();

    final total = totalHarga;
    final jumlahItem = widget.cartItems.length;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                color: Color(0xFFE85D04),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Konfirmasi Pesanan',
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pastikan pesanan kamu sudah sesuai sebelum melanjutkan.',
                  style: TextStyle(
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 15),

                _confirmationRow(
                  'Jumlah item',
                  '$jumlahItem item',
                ),

                const SizedBox(height: 8),

                _confirmationRow(
                  'Total pesanan',
                  formatRupiah(total),
                  highlight: true,
                ),

                if (catatan.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFFFFF8F2),
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Catatan',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          catatan,
                          style:
                              const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
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
                Navigator.pop(dialogContext);

                setState(() {
                  lastOrderTotal = total;
                  lastOrderItems = jumlahItem;

                  orderNumber =
                      _generateOrderNumber();

                  widget.cartItems.clear();
                  catatanController.clear();

                  orderCompleted = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFE85D04),
                foregroundColor: Colors.white,
                elevation: 0,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Konfirmasi',
              ),
            ),
          ],
        );
      },
    );
  }

  // ======================================================
  // NOMOR PESANAN
  // ======================================================

  String _generateOrderNumber() {
    final now = DateTime.now();

    return 'DN${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';
  }

  // ======================================================
  // BUILD
  // ======================================================

  @override
  Widget build(BuildContext context) {
    // ====================================================
    // HALAMAN PESANAN BERHASIL
    // ====================================================

    if (orderCompleted) {
      return _orderSuccess();
    }

    // ====================================================
    // EMPTY CART
    // ====================================================

    if (widget.cartItems.isEmpty) {
      return _emptyCart();
    }

    final quantities = itemQuantities;
    final items = uniqueItems;

    // ====================================================
    // CART
    // ====================================================

    return SafeArea(
      child: Column(
        children: [
          // ==============================================
          // HEADER
          // ==============================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              10,
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE8D6),
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Color(0xFFE85D04),
                    size: 25,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Keranjang Kamu',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF2D2D2D),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${widget.cartItems.length} item dipilih',
                        style:
                            const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ==============================================
          // LIST ITEM
          // ==============================================

          Expanded(
            child: ListView.builder(
              physics:
                  const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                20,
              ),
              itemCount: items.length,
              itemBuilder:
                  (context, index) {
                final menu = items[index];
                final quantity =
                    quantities[menu.id] ?? 0;

                return _cartItem(
                  menu,
                  quantity,
                );
              },
            ),
          ),

          // ==============================================
          // SUMMARY
          // ==============================================

          Container(
            padding:
                const EdgeInsets.fromLTRB(
              20,
              16,
              20,
              20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.06,
                  ),
                  blurRadius: 15,
                  offset:
                      const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                // ----------------------------------------
                // CATATAN
                // ----------------------------------------

                TextField(
                  controller:
                      catatanController,
                  maxLines: 2,
                  decoration:
                      InputDecoration(
                    hintText:
                        'Contoh: Tidak pedas, tambah sambal...',
                    hintStyle:
                        const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    prefixIcon:
                        const Padding(
                      padding:
                          EdgeInsets.only(
                        bottom: 18,
                      ),
                      child: Icon(
                        Icons.edit_note,
                        color:
                            Color(0xFFE85D04),
                      ),
                    ),
                    filled: true,
                    fillColor:
                        const Color(
                      0xFFFFF8F2,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),
                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                      borderSide:
                          const BorderSide(
                        color:
                            Color(0xFFE85D04),
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.all(
                      12,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ----------------------------------------
                // SUBTOTAL
                // ----------------------------------------

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      formatRupiah(
                        totalHarga,
                      ),
                      style:
                          const TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  children: [
                    const Text(
                      'Biaya layanan',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'Gratis',
                      style: TextStyle(
                        color:
                            Color(0xFFE85D04),
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                const Divider(),

                const SizedBox(height: 7),

                // ----------------------------------------
                // TOTAL
                // ----------------------------------------

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  children: [
                    const Text(
                      'Total Pesanan',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    Text(
                      formatRupiah(
                        totalHarga,
                      ),
                      style:
                          const TextStyle(
                        color:
                            Color(0xFFE85D04),
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ----------------------------------------
                // CHECKOUT
                // ----------------------------------------

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child:
                      ElevatedButton.icon(
                    onPressed: checkout,
                    icon: const Icon(
                      Icons
                          .shopping_bag_outlined,
                    ),
                    label: const Text(
                      'Pesan Sekarang',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFFE85D04,
                      ),
                      foregroundColor:
                          Colors.white,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // CART ITEM
  // ======================================================

  Widget _cartItem(
    MenuItem menu,
    int quantity,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      padding:
          const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 8,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // FOTO
          Container(
            width: 75,
            height: 75,
            decoration:
                BoxDecoration(
              color:
                  const Color(0xFFFFE8D6),
              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),
            clipBehavior:
                Clip.antiAlias,
            child: menu.image.startsWith(
              'assets/',
            )
                ? Image.asset(
                    menu.image,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context,
                            error,
                            stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons
                              .image_not_supported,
                          color: Color(
                            0xFFE85D04,
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      menu.image,
                      style:
                          const TextStyle(
                        fontSize: 34,
                      ),
                    ),
                  ),
          ),

          const SizedBox(width: 12),

          // INFO
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  menu.name,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      menu.rating
                          .toString(),
                      style:
                          const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  formatRupiah(
                    menu.price,
                  ),
                  style:
                      const TextStyle(
                    color:
                        Color(0xFFE85D04),
                    fontSize: 13,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 5),

          // QUANTITY
          Column(
            children: [
              Row(
                children: [
                  _quantityButton(
                    icon: Icons.remove,
                    onTap: () {
                      if (quantity == 1) {
                        hapusItem(menu);
                      } else {
                        kurangiQuantity(
                          menu,
                        );
                      }
                    },
                  ),

                  Padding(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 9,
                    ),
                    child: Text(
                      '$quantity',
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  _quantityButton(
                    icon: Icons.add,
                    onTap: () {
                      tambahQuantity(
                        menu,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 7),

              Text(
                formatRupiah(
                  menu.price * quantity,
                ),
                style:
                    const TextStyle(
                  color:
                      Color(0xFFE85D04),
                  fontSize: 11,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ======================================================
  // QUANTITY BUTTON
  // ======================================================

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(8),
      child: Container(
        width: 28,
        height: 28,
        decoration:
            BoxDecoration(
          color:
              const Color(0xFFFFE8D6),
          borderRadius:
              BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color:
              const Color(0xFFE85D04),
        ),
      ),
    );
  }

  // ======================================================
  // CONFIRMATION ROW
  // ======================================================

  Widget _confirmationRow(
    String title,
    String value, {
    bool highlight = false,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: highlight
                ? const Color(0xFF2D2D2D)
                : Colors.grey,
            fontSize: 14,
            fontWeight: highlight
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: highlight
                ? const Color(0xFFE85D04)
                : const Color(0xFF333333),
            fontSize: highlight
                ? 16
                : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ======================================================
  // EMPTY CART
  // ======================================================

  Widget _emptyCart() {
    return SafeArea(
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration:
                    const BoxDecoration(
                  color:
                      Color(0xFFFFE8D6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons
                      .shopping_cart_outlined,
                  size: 58,
                  color:
                      Color(0xFFE85D04),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Keranjang Masih Kosong',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Color(0xFF2D2D2D),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Yuk pilih makanan dan minuman favoritmu dari menu Dapur Nusantara.',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                height: 48,
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 24,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFFE85D04,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child: const Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Icon(
                      Icons
                          .restaurant_menu,
                      color:
                          Colors.white,
                      size: 19,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Yuk pilih menu favoritmu',
                      style: TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 13,
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

  // ======================================================
  // ORDER SUCCESS
  // ======================================================

  Widget _orderSuccess() {
    return SafeArea(
      child: SingleChildScrollView(
        physics:
            const BouncingScrollPhysics(),
        padding:
            const EdgeInsets.fromLTRB(
          20,
          30,
          20,
          30,
        ),
        child: Column(
          children: [
            // ==========================================
            // SUCCESS ICON
            // ==========================================

            Container(
              width: 105,
              height: 105,
              decoration:
                  const BoxDecoration(
                color: Color(0xFFFFE8D6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Color(0xFFE85D04),
                size: 72,
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Pesanan Berhasil! 🎉',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Pesananmu sudah diterima oleh Dapur Nusantara.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 22),

            // ==========================================
            // ORDER NUMBER
            // ==========================================

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withValues(
                      alpha: 0.04,
                    ),
                    blurRadius: 10,
                    offset:
                        const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Nomor Pesanan',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '#$orderNumber',
                    style:
                        const TextStyle(
                      color:
                          Color(0xFFE85D04),
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      const Text(
                        'Jumlah item',
                        style:
                            TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '$lastOrderItems item',
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style:
                            TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        formatRupiah(
                          lastOrderTotal,
                        ),
                        style:
                            const TextStyle(
                          color:
                              Color(0xFFE85D04),
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==========================================
            // STATUS PESANAN
            // ==========================================

            Align(
              alignment:
                  Alignment.centerLeft,
              child: const Text(
                'Status Pesanan',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Color(0xFF2D2D2D),
                ),
              ),
            ),

            const SizedBox(height: 15),

            _statusStep(
              icon: Icons.shopping_cart,
              title: 'Pesanan Dibuat',
              subtitle:
                  'Pesanan berhasil diterima',
              active: true,
              isLast: false,
            ),

            _statusStep(
              icon: Icons.restaurant,
              title: 'Sedang Diproses',
              subtitle:
                  'Pesanan sedang disiapkan',
              active: true,
              isLast: false,
            ),

            _statusStep(
              icon: Icons.takeout_dining,
              title: 'Siap Diambil',
              subtitle:
                  'Pesanan akan segera siap',
              active: false,
              isLast: true,
            ),

            const SizedBox(height: 20),

            // ==========================================
            // INFO
            // ==========================================

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color:
                    const Color(0xFFFFE8D6),
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
              child: const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color:
                        Color(0xFFE85D04),
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pesanan sedang diproses oleh Dapur Nusantara. Silakan tunggu hingga pesanan siap.',
                      style: TextStyle(
                        color:
                            Color(0xFF7A4A2A),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==========================================
            // BUTTON
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    orderCompleted = false;
                  });
                },
                icon: const Icon(
                  Icons.restaurant_menu,
                ),
                label: const Text(
                  'Pesan Menu Lain',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xFFE85D04,
                  ),
                  foregroundColor:
                      Colors.white,
                  elevation: 0,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======================================================
  // STATUS STEP
  // ======================================================

  Widget _statusStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool active,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration:
                  BoxDecoration(
                color: active
                    ? const Color(
                        0xFFE85D04,
                      )
                    : const Color(
                        0xFFFFE8D6,
                      ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: active
                    ? Colors.white
                    : const Color(
                        0xFFE85D04,
                      ),
                size: 21,
              ),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 38,
                color: active
                    ? const Color(
                        0xFFE85D04,
                      )
                    : const Color(
                        0xFFFFE8D6,
                      ),
              ),
          ],
        ),

        const SizedBox(width: 13),

        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(
              top: 2,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 14,
                    color: active
                        ? const Color(
                            0xFF2D2D2D,
                          )
                        : Colors.grey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style:
                      const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                if (!isLast)
                  const SizedBox(
                    height: 20,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}