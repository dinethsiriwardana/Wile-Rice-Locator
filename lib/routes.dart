import 'package:flutter/material.dart';
import 'package:wild_rice_locator/presentation/page/auth/user_registraion.dart';
import 'package:wild_rice_locator/presentation/page/home/home_page.dart';
import 'package:wild_rice_locator/presentation/page/landing_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/landing': (context) => const LandingPage(),
  '/home': (context) => const HomePage(),
  '/userregistraion': (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return UserRegistration(
      uid: (args != null && args.containsKey('uid'))
          ? args['uid'] as String
          : '',
    );
  }
};
