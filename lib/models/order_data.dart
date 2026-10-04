import 'menu_item.dart';

class OrderData {
  final MenuItem menu;
  int quantity;

  OrderData({
    required this.menu,
    this.quantity = 1,
  });

  int get total {
    return menu.price * quantity;
  }
}