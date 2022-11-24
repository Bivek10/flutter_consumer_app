import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../injector.dart';
import '../providers/email_auth_provider.dart';
import 'waiter_page/home_page.dart';
import 'login_page.dart';

class MainPage extends StatefulWidget {
  static const pageUrl = "/";
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late String uid;
  @override
  void initState() {
    uid = sharedPreferences.getString("uid")!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return uid.isNotEmpty
        ? const HomePage()
        : Consumer<EmailAuthentication>(builder: (context, value, child) {
            return value.authenticationState == AuthState.loaded
                ? const HomePage()
                : const LoginPage(
                    entryType: EntryType.login,
                  );
          });
  }
}
