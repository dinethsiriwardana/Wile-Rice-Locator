part of 'get_avaiable_locations_bloc.dart';

@immutable
sealed class GetAvaiableLocationsEvent {}

final class GetAvaiableLocations extends GetAvaiableLocationsEvent {}

final class GetAvaiableLocationsMap extends GetAvaiableLocationsEvent {}
