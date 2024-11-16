part of 'get_avaiable_locations_bloc.dart';

@immutable
sealed class GetAvaiableLocationsState {}

final class GetAvaiableLocationsInitial extends GetAvaiableLocationsState {}

final class GetAvaiableLocationsLoading extends GetAvaiableLocationsState {}

final class GetAvaiableLocationsLoaded extends GetAvaiableLocationsState {
  final List<LocationModelFb> locations;
  GetAvaiableLocationsLoaded(this.locations);
}