import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wild_rice_locator/bloc/auth/auth_bloc.dart';
import 'package:wild_rice_locator/bloc/fetch_data/fetch_data_bloc.dart';
import 'package:wild_rice_locator/bloc/phone_auth/auth_bloc.dart';
import 'package:wild_rice_locator/bloc/show_rice_data/show_rice_data_bloc.dart';
import 'package:wild_rice_locator/data/service/rice_data.dart';
import 'package:wild_rice_locator/firebase_options.dart';
import 'package:wild_rice_locator/l10n/l10n.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wild_rice_locator/presentation/page/auth/login_phone.dart';
import 'package:wild_rice_locator/presentation/page/landing_page.dart';
import 'package:wild_rice_locator/routes.dart';
import 'package:wild_rice_locator/theme.dart';

Future<void> main() async {
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
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeData,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          routes: appRoutes,
          home: const LandingPage(),
        );
      }),
    );
  }
}

// class LocalizedHome extends StatelessWidget {
//   const LocalizedHome({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Demo'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text(AppLocalizations.of(context)?.title ?? '...',
//                 style: Theme.of(context).textTheme.displaySmall),
//           ],
//         ),
//       ),
//     );
//   }
// }
