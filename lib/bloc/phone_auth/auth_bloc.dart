import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:wild_rice_locator/data/firebase_service/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  PhoneAuthBloc() : super(PhoneAuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  Future<void> _onSendOtp(
      SendOtpEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print(credential);
          await _auth.signInWithCredential(credential);
          emit(PhoneAuthVerified());
        },
        verificationFailed: (FirebaseAuthException e) {
          print('verificationFailed: ${e.code} - ${e.message}- ${e.plugin}');
          emit(PhoneAuthError(e.message ?? 'Verification failed'));
        },
        codeSent: (String verificationId, int? resendToken) {
          print(verificationId);
          _verificationId = verificationId;
          emit(PhoneAuthCodeSent());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      emit(PhoneAuthError(e.toString()));
    }
  }

  Future<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: event.otp,
      );
      final result = await _auth.signInWithCredential(credential);
      print(result);
      emit(PhoneAuthVerified());
    } catch (e) {
      emit(PhoneAuthError(e.toString()));
    }
  }
}
