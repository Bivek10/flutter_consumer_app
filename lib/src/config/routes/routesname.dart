import 'package:flutter_skeleton/src/pages/view_order/view_order_page.dart';

import '../../pages/categories/add_categories_form.dart';
import '../../pages/categories/add_food_form.dart';
import '../../pages/categories/manage_category_home.dart';
import '../../pages/display_menu/food_view.dart';
import '../../pages/login/register/registration.dart';
import '../../pages/manage_staff/staff_setting.dart';
import '../../pages/manage_table/add_table.dart';
import '../../pages/waiter_page/home_page.dart';
import '../../pages/login/register/login_page.dart';
import '../../pages/main_page.dart';
import '../../pages/display_menu/menu_list.dart';
import '../../pages/profile.dart';

class RouteName {
  static const loginpage = LoginPage.pageUrl;
  static const registrationpage = RegistrationPage.pageUrl;
  static const mainPage = MainPage.pageUrl;
  static const homepage = HomePage.pageUrl;
  static const profile = Profile.pageUrl;
  static const menulist = MenuList.pageUrl;
  static const addtable = AddTable.pageUrl;
  static const managestaff = StaffSetting.pageUrl;
  static const categoryform = AddCategoires.pageUrl;
  static const categoryHome = CategoryHome.pageUrl;
  static const foodform = AddFoodMenu.pageUrl;
  static const foodmenu = FoodMenu.pageUrl;
  static const orderpage = ViewOrder.pageUrl;
}
