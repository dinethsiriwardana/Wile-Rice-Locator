part of 'getlocation_bloc.dart';

@immutable
sealed class GetlocationEvent {}

class GetLocation extends GetlocationEvent {}

class UpdateLocation extends GetlocationEvent {
  final Position position;
  UpdateLocation(this.position);
}
