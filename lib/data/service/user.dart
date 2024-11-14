import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wild_rice_locator/domain/model/user_model.dart';

class UserData {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<UserDataModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await db.collection('user').doc(uid).get();

      if (doc.exists) {
        return UserDataModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  // save data
  Future<bool> saveUserData(UserDataModel userData) async {
    try {
      print(userData.toJson());
      await db.collection('user').doc(userData.uid).set(userData.toJson());

      return true;
    } catch (e) {
      print('Error saving user data: $e');
      return false;
    }
  }
}

      // docRef.get().then((querySnapshot) {
      //   querySnapshot.docs.forEach((result) {
      //     print(result.id);
      //   });
      // });