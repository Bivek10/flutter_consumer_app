import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/pages/demo.dart';

import '../../pages/login_page.dart';
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
      case RouteName.loginpage:
        EntryType type =
            settings.arguments == null ? EntryType.login : EntryType.register;

        return _materialRoute(
          LoginPage(
            entryType: type,
          ),
        );
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
