import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wild_rice_locator/domain/model/local/location_model.dart';

class GetUserLocation {
  GoogleMapController? mapController;
  Position? currentPosition;
  String currentAddress = "Loading...";
  final Set<Marker> markers = {};

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      currentAddress = 'Location services are disabled';
      return;
    }
    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        currentAddress = 'Location permissions are denied';
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      currentAddress = 'Location permissions are permanently denied';
      return;
    }
    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition = position;
    } catch (e) {
      print("Error getting current location: $e");
      currentAddress = 'Error getting location';
    }
  }

  Future<LocationModel> updateLocation(Position position) async {
    currentPosition = position;
    return await getAddressFromLatLng();
  }

  Future<LocationModel> getAddressFromLatLng() async {
    try {
      if (currentPosition == null) {
        await _getCurrentLocation();
      }
      var googleGeocoding =
          GoogleGeocodingApi("AIzaSyBBSekLvvFy9MAUoftpdhP6Q2sBvUg5XIs");

      String coordinates =
          '${currentPosition?.latitude}, ${currentPosition?.longitude}';

      final reversedSearchResults = await googleGeocoding.reverse(
        coordinates,
        language: 'en',
      );

      final prettyAddress =
          reversedSearchResults.results.firstOrNull?.mapToPretty();
      if (prettyAddress == null) {
        throw Exception('No address found');
      }

      print(
          "postalCode: ${prettyAddress.postalCode}, streetNumber: ${prettyAddress.streetNumber}, streetName: ${prettyAddress.streetName}, city: ${prettyAddress.city}, state: ${prettyAddress.state}, stateCode: ${prettyAddress.stateCode}, placeId: ${prettyAddress.placeId}, country: ${prettyAddress.country}, address: ${prettyAddress.address}, countryCode: ${prettyAddress.countryCode}, latitude: ${prettyAddress.latitude}, longitude: ${prettyAddress.longitude}");

      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: LatLng(
            currentPosition!.latitude,
            currentPosition!.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: currentAddress,
          ),
        ),
      );

      final location =
          LocationModel(prettyAddress: prettyAddress, markers: markers);
      return location;
    } catch (e) {
      print("Error getting address: $e");

      currentAddress = "Could not fetch address";

      // Throw the error to be handled by the caller
      throw Exception('Failed to get address: $e');
    }
  }
}
