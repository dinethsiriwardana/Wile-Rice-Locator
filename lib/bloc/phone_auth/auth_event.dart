part of 'auth_bloc.dart';

@immutable
sealed class PhoneAuthEvent {}

class SendOtpEvent extends PhoneAuthEvent {
  final String phoneNumber;
  SendOtpEvent(this.phoneNumber);
}

class VerifyOtpEvent extends PhoneAuthEvent {
  final String otp;
  VerifyOtpEvent(this.otp);
}
