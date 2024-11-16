part of 'getlocation_bloc.dart';

@immutable
sealed class GetlocationState {}

final class GetlocationInitial extends GetlocationState {}

final class GetlocationLoading extends GetlocationState {}

final class GetlocationLoaded extends GetlocationState {
  final LocationModel location;
  GetlocationLoaded(this.location);
}

final class GetlocationError extends GetlocationState {
  final String error;
  GetlocationError(this.error);
}
