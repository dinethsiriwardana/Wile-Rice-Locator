import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wild_rice_locator/bloc/auth/auth_bloc.dart';
import 'package:wild_rice_locator/bloc/fetch_data/fetch_data_bloc.dart';
import 'package:wild_rice_locator/bloc/get_avaiable_locations/get_avaiable_locations_bloc.dart';
import 'package:wild_rice_locator/bloc/get_location/getlocation_bloc.dart';
import 'package:wild_rice_locator/bloc/phone_auth/auth_bloc.dart';
import 'package:wild_rice_locator/bloc/show_rice_data/show_rice_data_bloc.dart';
import 'package:wild_rice_locator/data/firebase_service/rice_data.dart';
import 'package:wild_rice_locator/firebase_options.dart';
import 'package:wild_rice_locator/l10n/l10n.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wild_rice_locator/presentation/page/add_location/add_location.dart';
import 'package:wild_rice_locator/presentation/page/auth/login_phone.dart';
import 'package:wild_rice_locator/presentation/page/landing_page.dart';
import 'package:wild_rice_locator/presentation/page/map/map.dart';
import 'package:wild_rice_locator/presentation/page/show_locations/show_locations.dart';
import 'package:wild_rice_locator/routes.dart';
import 'package:wild_rice_locator/theme.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    // Add custom error handling logic
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PhoneAuthBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckAuthEvent()),
        ),
        BlocProvider(create: (context) => FetchDataBloc()..add(FetchData())),
        BlocProvider(create: (context) => ShowRiceDataBloc()),
        BlocProvider(
            create: (context) => GetlocationBloc()..add(GetLocation())),
        BlocProvider(
            create: (context) =>
                GetAvaiableLocationsBloc()..add(GetAvaiableLocations())),
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeData,
          // localizationsDelegates: AppLocalizations.localizationsDelegates,
          // supportedLocales: AppLocalizations.supportedLocales,
          // locale: const Locale('en'),
          routes: appRoutes,
          // home: const AllMap(),
          home: const LandingPage(),
        );
      }),
    );
  }
}
