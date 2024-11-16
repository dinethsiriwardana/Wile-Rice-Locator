import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wild_rice_locator/bloc/auth/auth_bloc.dart';
import 'package:wild_rice_locator/data/firebase_service/user.dart';
import 'package:wild_rice_locator/presentation/page/auth/login_phone.dart';
import 'package:wild_rice_locator/presentation/page/auth/user_registraion.dart';
import 'package:wild_rice_locator/presentation/page/home/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated || state is AuthError) {
          Navigator.pushNamed(context, '/login');
        } else if (state is AuthAuthenticated) {
          Navigator.pushNamed(context, '/home', arguments: {'uid': ""});
          ;
        } else if (state is AuthUnRegisterd) {
          // return UserRegistration(uid: state.user);
          Navigator.pushNamed(context, '/userregistraion',
              arguments: {'uid': state.user});
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
