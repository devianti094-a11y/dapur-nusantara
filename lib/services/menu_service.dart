import '../models/menu_item.dart';
import '../utils/constants.dart';

class MenuService {
  static List<MenuItem> getMenu() {
    return AppConstants.menuList;
  }
}