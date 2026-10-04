import '../models/menu_item.dart';

class AppConstants {
  static const String restaurantName = 'Dapur Nusantara';

  static final List<MenuItem> menuList = [

    // =====================================
    // MAKANAN
    // =====================================

    MenuItem(
      id: '1',
      name: 'Nasi Goreng Spesial',
      description:
          'Nasi goreng dengan telur, ayam, dan sayuran.',
      price: 18000,
      category: 'Makanan',
      image: 'assets/images/nasi goreng spesial.jpeg',
      rating: 4.8,
    ),

    MenuItem(
      id: '2',
      name: 'Ayam Geprek',
      description:
          'Ayam crispy dengan sambal geprek pedas.',
      price: 20000,
      category: 'Makanan',
      image: 'assets/images/ayam geprek.jpeg',
      rating: 4.9,
    ),

    MenuItem(
      id: '3',
      name: 'Mie Goreng',
      description:
          'Mie goreng spesial dengan telur dan sayuran.',
      price: 15000,
      category: 'Makanan',
      image: 'assets/images/mie goreng.jpeg',
      rating: 4.7,
    ),

    MenuItem(
      id: '4',
      name: 'Sate Ayam',
      description:
          'Sate ayam dengan bumbu kacang khas Nusantara.',
      price: 22000,
      category: 'Makanan',
      image: 'assets/images/sate ayam.jpeg',
      rating: 4.8,
    ),

    MenuItem(
      id: '7',
      name: 'Nasi Pecel',
      description:
          'Nasi dengan sayuran segar dan sambal pecel khas Nusantara.',
      price: 15000,
      category: 'Makanan',
      image: 'assets/images/nasi pecel.jpeg',
      rating: 4.9,
    ),

    MenuItem(
      id: '8',
      name: 'Rendang',
      description:
          'Daging sapi empuk dengan bumbu rendang khas Indonesia.',
      price: 25000,
      category: 'Makanan',
      image: 'assets/images/rendang.jpeg',
      rating: 4.9,
    ),

    MenuItem(
      id: '9',
      name: 'Soto Ayam',
      description:
          'Soto ayam hangat dengan kuah gurih dan segar.',
      price: 18000,
      category: 'Makanan',
      image: 'assets/images/soto ayam.jpeg',
      rating: 4.8,
    ),

    MenuItem(
      id: '12',
      name: 'Ayam Bakar Madu',
      description:
          'Ayam bakar lembut dengan bumbu madu yang manis dan gurih.',
      price: 23000,
      category: 'Makanan',
      image: 'assets/images/ayam bakar madu.jpeg',
      rating: 4.9,
    ),

    MenuItem(
      id: '13',
      name: 'Rawon',
      description:
          'Sup daging sapi dengan kuah kluwek khas Jawa Timur.',
      price: 22000,
      category: 'Makanan',
      image: 'assets/images/rawon.jpeg',
      rating: 4.9,
    ),

    MenuItem(
      id: '14',
      name: 'Gudeg Jogja',
      description:
          'Nangka muda dengan santan, telur, dan lauk khas Yogyakarta.',
      price: 20000,
      category: 'Makanan',
      image: 'assets/images/gudeg jogja.jpeg',
      rating: 4.8,
    ),

    MenuItem(
      id: '15',
      name: 'Udang Balado',
      description:
          'Udang segar dengan sambal balado yang gurih dan pedas.',
      price: 27000,
      category: 'Makanan',
      image: 'assets/images/udang balado',
      rating: 4.8,
    ),

    MenuItem(
      id: '16',
      name: 'Ikan Bakar Rica-Rica',
      description:
          'Ikan bakar dengan sambal rica-rica khas Nusantara.',
      price: 28000,
      category: 'Makanan',
      image: 'assets/images/ikan bakar rica rica.jpeg',
      rating: 4.9,
    ),

    MenuItem(
      id: '17',
      name: 'Bakso Nusantara',
      description:
          'Bakso sapi dengan kuah gurih, mie, dan sayuran.',
      price: 18000,
      category: 'Makanan',
      image: 'assets/images/bakso nusantara.jpeg',
      rating: 4.8,
    ),

    // =====================================
    // MINUMAN
    // =====================================

    MenuItem(
      id: '5',
      name: 'Es Teh Manis',
      description:
          'Es teh manis segar untuk menemani makananmu.',
      price: 7000,
      category: 'Minuman',
      image: 'assets/images/es teh.jpeg',
      rating: 4.6,
    ),

    MenuItem(
      id: '6',
      name: 'Jus Alpukat',
      description:
          'Jus alpukat segar dengan susu.',
      price: 13000,
      category: 'Minuman',
      image: 'assets/images/jus alpukat.jpeg',
      rating: 4.8,
    ),

    MenuItem(
      id: '10',
      name: 'Es Jeruk',
      description:
          'Es jeruk segar dengan rasa manis dan sedikit asam.',
      price: 7000,
      category: 'Minuman',
      image: 'assets/images/es jeruk.jpeg',
      rating: 4.7,
    ),

    MenuItem(
      id: '18',
      name: 'Es Cendol',
      description:
          'Cendol segar dengan santan dan gula merah.',
      price: 10000,
      category: 'Minuman',
      image: 'assets/images/es cendol.jpeg',
      rating: 4.8,
    ),

    MenuItem(
      id: '20',
      name: 'Jus Mangga',
      description:
          'Jus mangga segar dengan rasa manis dan menyegarkan.',
      price: 12000,
      category: 'Minuman',
      image: 'assets/images/jus mangga.jpeg',
      rating: 4.8,
    ),

    MenuItem(
      id: '21',
      name: 'Es Lemon Tea',
      description:
          'Teh dingin dengan perasan lemon yang menyegarkan.',
      price: 9000,
      category: 'Minuman',
      image: 'assets/images/es lemon tea.jpeg',
      rating: 4.7,
    ),

    MenuItem(
      id: '22',
      name: 'Es Kelapa Muda',
      description:
          'Kelapa muda segar dengan es untuk menemani harimu.',
      price: 12000,
      category: 'Minuman',
      image: 'assets/images/es kelapa muda.jpeg',
      rating: 4.9,
    ),

    // =====================================
    // DESSERT
    // =====================================

    MenuItem(
      id: '23',
      name: 'Puding Caramel',
      description:
          'Puding lembut dengan saus caramel manis yang menggoda.',
      price: 12000,
      category: 'Dessert',
      image: 'assets/images/pudding.jpeg',
      rating: 4.8,
    ),

    MenuItem(
      id: '24',
      name: 'Chocolate Lava Cake',
      description:
          'Cake cokelat lembut dengan lelehan cokelat di dalamnya.',
      price: 18000,
      category: 'Dessert',
      image: 'assets/images/lava_cake.jpeg',
      rating: 4.9,
    ),

    MenuItem(
      id: '25',
      name: 'Pisang Goreng Cokelat',
      description:
          'Pisang goreng renyah dengan topping cokelat dan keju.',
      price: 15000,
      category: 'Dessert',
      image: 'assets/images/pisang_coklat.jpeg',
      rating: 4.8,
    ),

    MenuItem(
      id: '26',
      name: 'Pancake',
      description:
          'Pancake lembut dengan sirup dan topping manis.',
      price: 16000,
      category: 'Dessert',
      image: 'assets/images/pancake.jpeg',
      rating: 4.7,
    ),

    MenuItem(
      id: '27',
      name: 'Es Krim Nusantara',
      description:
          'Es krim lembut dengan pilihan rasa khas Nusantara.',
      price: 14000,
      category: 'Dessert',
      image: 'assets/images/ice cream.jpeg',
      rating: 4.9,
    ),
  ];
}