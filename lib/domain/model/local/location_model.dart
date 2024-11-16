import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  GeocodingPrettyAddress prettyAddress;
  Set<Marker> markers;

  LocationModel({required this.prettyAddress, required this.markers});

  GeocodingPrettyAddress get getPrettyAddress => prettyAddress;
  set setPrettyAddress(GeocodingPrettyAddress value) {
    prettyAddress = value;
  }

  Set<Marker> get getMarkers => markers;
  set setMarkers(Set<Marker> value) {
    markers = value;
  }
}
