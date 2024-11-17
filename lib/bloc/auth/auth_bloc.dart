import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:wild_rice_locator/data/firebase_service/user.dart';
import 'package:wild_rice_locator/domain/model/firebase/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is CheckAuthEvent) {
        if (_auth.currentUser != null && _auth.currentUser!.uid.isNotEmpty) {
          String uid = _auth.currentUser!.uid;
          String? phoneNumber = _auth.currentUser!.phoneNumber;

          final user = await UserData().getUserData(uid);

          if (user != null) {
            emit(AuthAuthenticated(auth: user));
          } else {
            emit(AuthUnRegisterd(user: uid, number: phoneNumber ?? ""));
          }
        } else {
          emit(AuthUnauthenticated());
        }
      } else if (event is SignOutEvent) {}
    });
  }
}
