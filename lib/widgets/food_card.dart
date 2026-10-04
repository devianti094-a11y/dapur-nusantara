import 'package:flutter/material.dart';

import '../models/menu_item.dart';

class FoodCard extends StatelessWidget {
  final MenuItem menu;
  final VoidCallback onTap;
  final VoidCallback? onAdd;

  const FoodCard({
    super.key,
    required this.menu,
    required this.onTap,
    this.onAdd,
  });

  String formatRupiah(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      margin: const EdgeInsets.only(
        bottom: 14,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(18),

        // Klik kartu
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(14),

          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ================================
              // GAMBAR
              // ================================

              Container(
                width: 80,
                height: 80,

                decoration: BoxDecoration(
                  color: const Color(0xFFFFE8D6),

                  borderRadius:
                      BorderRadius.circular(15),
                ),

                clipBehavior:
                    Clip.antiAlias,

                child: menu.image.startsWith(
                  'assets/',
                )
                    ? Image.asset(
                        menu.image,

                        width: 80,
                        height: 80,

                        fit: BoxFit.cover,

                        errorBuilder:
                            (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return const Center(
                            child: Icon(
                              Icons.image_not_supported,

                              color:
                                  Color(0xFFE85D04),

                              size: 35,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          menu.image,

                          style:
                              const TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
              ),

              const SizedBox(width: 14),

              // ================================
              // INFORMASI
              // ================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      menu.name,

                      style:
                          const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      menu.description,

                      maxLines: 2,

                      overflow:
                          TextOverflow.ellipsis,

                      style: TextStyle(
                        color:
                            Colors.grey.shade600,

                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 17,
                          color: Colors.amber,
                        ),

                        const SizedBox(width: 4),

                        Text(
                          menu.rating.toString(),

                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),

                        const Spacer(),

                        Text(
                          formatRupiah(
                            menu.price,
                          ),

                          style:
                              const TextStyle(
                            color:
                                Color(0xFFE85D04),

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    // ================================
                    // TOMBOL TAMBAH
                    // HANYA MUNCUL JIKA onAdd ADA
                    // ================================

                    if (onAdd != null) ...[
                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,

                        height: 38,

                        child:
                            ElevatedButton.icon(
                          onPressed: onAdd,

                          icon:
                              const Icon(
                            Icons.add_shopping_cart,
                            size: 18,
                          ),

                          label:
                              const Text(
                            'Tambah',
                          ),

                          style:
                              ElevatedButton
                                  .styleFrom(
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
                                  BorderRadius
                                      .circular(
                                10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}