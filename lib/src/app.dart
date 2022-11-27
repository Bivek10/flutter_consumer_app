import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/providers/image_file_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'config/routes/app_routes.dart';
import 'config/routes/routesname.dart';
import 'config/themes/app_theme.dart';
import 'pages/login/register/login_page.dart';
import 'providers/auth_provider.dart';
import 'providers/email_auth_provider.dart';
import 'providers/onboarding_provider.dart';

final mainNavigator = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => OnboardingProvider(),
        // ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmailAuthentication(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImageFileReciver(),
        )
      ],
      builder: (context, child) {
        return Sizer(builder: (_, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: mainNavigator,
            title: tr("Skeleton"),
            theme: AppTheme.light,
            initialRoute: RouteName.mainPage,
            onGenerateRoute: AppRouter.onGenerateRoutes,
            // initialRoute:
            //     context.watch<OnboardingProvider>().shouldShowOnboardingPage
            //         ? LoginPage.pageUrl
            //
            //     : "/",
            // onGenerateRoute: (settings) {
            //   return AppRouter.onGenerateRoutes(settings,
            //       Provider.of<AuthProvider>(context, listen: false).loggedIn);
            // },
            localizationsDelegates: [
              FormBuilderLocalizations.delegate,
              ...context.localizationDelegates
            ],
            supportedLocales: context.supportedLocales,
          );
        });
      },
    );
  }
}
