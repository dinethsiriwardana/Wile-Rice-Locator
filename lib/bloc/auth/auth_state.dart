part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final UserDataModel? auth;
  AuthAuthenticated({required this.auth});
}

final class AuthUnauthenticated extends AuthState {}

final class AuthRegisterd extends AuthState {}

final class AuthUnRegisterd extends AuthState {
  final String user;
  AuthUnRegisterd({required this.user});
}

final class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}
