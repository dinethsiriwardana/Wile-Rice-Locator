part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
