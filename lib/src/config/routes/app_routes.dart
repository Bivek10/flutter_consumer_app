import 'package:flutter/material.dart';

import '../../pages/categories/add_categories_form.dart';
import '../../pages/categories/add_food_form.dart';
import '../../pages/categories/manage_category_home.dart';
import '../../pages/demo.dart';
import '../../pages/display_menu/food_view.dart';
import '../../pages/login/register/registration.dart';
import '../../pages/manage_staff/staff_setting.dart';
import '../../pages/manage_table/add_table.dart';
import '../../pages/waiter_page/home_page.dart';
import '../../pages/login/register/login_page.dart';
import '../../pages/main_page.dart';
import '../../pages/display_menu/menu_list.dart';
import '../../pages/profile.dart';
import '../../pages/waiter_page/roms_table.dart';
import 'routesname.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    /*  
    if (!isLoggedIn) {
      switch (settings.name) {
        case 'login':
          return _materialRoute(const Demo(title: "Login"));
        case 'register':
          return _materialRoute(const Demo(title: 'Register'));
      }
    }

    if (isLoggedIn) {
      switch (settings.name) {
        case 'update_profile':
          return _materialRoute(const Demo(title: 'Update Profile'));
      }
    }
  */

    switch (settings.name) {
      case RouteName.mainPage:
        return _materialRoute(const MainPage());

      case RouteName.loginpage:
        return _materialRoute(
          const LoginPage(),
        );
      case RouteName.registrationpage:
        return _materialRoute(const RegistrationPage());
      case RouteName.homepage:
        return _materialRoute(const HomePage());
      case RouteName.profile:
        return _materialRoute(const Profile());
      case RouteName.menulist:
        return _materialRoute(const MenuList());
      case RouteName.managestaff:
        return _materialRoute(const StaffSetting());
      case RouteName.categoryHome:
        return _materialRoute(const CategoryHome());
      case RouteName.foodmenu:
        TableModel tableModel = settings.arguments as TableModel;
        return _materialRoute(FoodMenu(
          tableModel: tableModel,
        ));
      // case RouteName.foodform:
      //   String categoryID = settings.arguments as String;
      //   return _materialRoute(AddFoodMenu(
      //     categoryID: categoryID,
      //   ));
      case RouteName.categoryform:
        EditFormValue editFormValue = settings.arguments as EditFormValue;
        return _materialRoute(AddCategoires(editFormValue: editFormValue));
      case RouteName.addtable:
        EditFormValue editFormValue = settings.arguments as EditFormValue;
        return _materialRoute(AddTable(
          editFormValue: editFormValue,
        ));
      case 'about':
        final DemoScreenArguments args =
            settings.arguments as DemoScreenArguments;
        return _materialRoute(Demo(title: "About", args: args));
      default:
        throw const FormatException('Route not found');
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
