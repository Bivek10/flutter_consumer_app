import 'package:flutter/material.dart';

import '../../pages/demo.dart';
import '../../pages/login/register/registration.dart';
import '../../pages/waiter_page/home_page.dart';
import '../../pages/login/register/login_page.dart';
import '../../pages/main_page.dart';
import '../../pages/menu_list.dart';
import '../../pages/profile.dart';
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
