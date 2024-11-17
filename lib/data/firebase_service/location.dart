import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wild_rice_locator/data/firebase_service/auth.dart';
import 'package:wild_rice_locator/data/firebase_service/user.dart';
import 'package:wild_rice_locator/domain/model/firebase/location_model_fb.dart';
import 'package:wild_rice_locator/domain/model/firebase/user_model.dart';
import 'package:wild_rice_locator/domain/model/local/location_model.dart';

class LocationHandler {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = Auth();
  final userdata = UserData();

  Future<Map<String, String>> addLocation(
      LocationModelFb locationModelFb) async {
    try {
      final user = auth.currentUser;

      UserDataModel? userd = await userdata.getUserData(user!.uid);

      locationModelFb.user = userd;

      // print(locationModelFb.formdata.toJson());

      final result =
          await _firestore.collection('location').add(locationModelFb.toJson());
      return {"status": "success", "id": result.id};
    } catch (e) {
      print("Error on AddLocationFirebase: " + e.toString());
      return {"status": "error", "message": e.toString()};
    }
  }

  Future<List<LocationModelFb>> getLocations() async {
    try {
      final result = await _firestore.collection('location').get();

      // print data

      return result.docs
          .map(
              (e) => LocationModelFb.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      return [];
    } catch (e) {
      print("Error on GetLocationsFirebase: " + e.toString());
      return [];
    }
  }

  Future<Set<Marker>> getMarkers() async {
    try {
      final result = await _firestore.collection('location').get();
      final Set<Marker> markers = {};

      for (var doc in result.docs) {
        final location =
            LocationModelFb.fromJson(doc.data() as Map<String, dynamic>);

        // Determine marker color based on postal code
        double markerColor;
        double getHueFromColor(Color color) {
          HSLColor hslColor = HSLColor.fromColor(color);
          return hslColor.hue;
        }

        if (location.formdata.ricetype == "Oryza nivara") {
          markerColor = BitmapDescriptor.hueBlue;
        } else if (location.formdata.ricetype == "Oryza rufipogon") {
          markerColor = getHueFromColor(Colors.brown);
        } else if (location.formdata.ricetype == "Oryza rhizomatis") {
          markerColor = BitmapDescriptor.hueRed;
        } else if (location.formdata.ricetype == "Oryza granulata") {
          markerColor = BitmapDescriptor.hueViolet;
        } else if (location.formdata.ricetype == "Oryza eichingeri") {
          markerColor = BitmapDescriptor.hueYellow;
        } else {
          markerColor = BitmapDescriptor.hueGreen;
        }

        markers.add(
          Marker(
            markerId: MarkerId(location.prettyAddress.placeId),
            position: LatLng(
              location.prettyAddress.latitude,
              location.prettyAddress.longitude,
            ),
            infoWindow: InfoWindow(title: location.formdata.ricetype),
            icon: BitmapDescriptor.defaultMarkerWithHue(markerColor),
          ),
        );
      }

      return markers;
    } catch (e) {
      print("Error on GetLocationsFirebase: $e");
      return {};
    }
  }
}
