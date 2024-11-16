import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
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
}
