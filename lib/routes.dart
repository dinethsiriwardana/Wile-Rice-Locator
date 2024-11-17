import 'package:flutter/material.dart';
import 'package:wild_rice_locator/domain/model/firebase/location_model_fb.dart';
import 'package:wild_rice_locator/presentation/page/add_location/add_location.dart';
import 'package:wild_rice_locator/presentation/page/auth/user_registraion.dart';
import 'package:wild_rice_locator/presentation/page/home/home_page.dart';
import 'package:wild_rice_locator/presentation/page/landing_page.dart';
import 'package:wild_rice_locator/presentation/page/map/map.dart';
import 'package:wild_rice_locator/presentation/page/show_locations/show_full_details.dart';
import 'package:wild_rice_locator/presentation/page/show_locations/show_locations.dart';

import 'presentation/page/auth/login_phone.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/landing': (context) => const LandingPage(),
  '/home': (context) => const HomePage(),
  '/addlocation': (context) => const AddLocation(),
  '/userregistraion': (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return UserRegistration(
      uid: (args != null && args.containsKey('uid'))
          ? args['uid'] as String
          : '',
    );
  },
  '/userregistraion': (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return UserRegistration(
      uid: (args != null && args.containsKey('uid'))
          ? args['uid'] as String
          : '',
    );
  },
  '/login': (context) => const LoginScreen(),
  '/showlocations': (context) => const ShowLocations(),
  '/allMap': (context) => const AllMap(),
  '/ShowFullDetails': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return ShowFullDetails(
      locationModelFb: (args.containsKey('locationModelFb'))
          ? args['locationModelFb']
          : null,
    );
  }
};
