import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:wild_rice_locator/domain/model/firebase/user_model.dart';

class LocationModelFb {
  GeocodingPrettyAddress prettyAddress;
  UserDataModel? user;
  FormDataModel formdata;
  DateTime? createdDate;

  LocationModelFb(
      {required this.prettyAddress,
      this.user,
      required this.formdata,
      this.createdDate});

  Map<String, dynamic> prettyAddressMaptoJson() {
    final Map<String, dynamic> prettyAddressMap = {
      'address': prettyAddress.address,
      'city': prettyAddress.city,
      'country': prettyAddress.country,
      'countryCode': prettyAddress.countryCode,
      'postalCode': prettyAddress.postalCode,
      'state': prettyAddress.state,
      'stateCode': prettyAddress.stateCode,
      'streetNumber': prettyAddress.streetNumber,
      'streetName': prettyAddress.streetName,
      'placeId': prettyAddress.placeId,
      'latitude': prettyAddress.latitude,
      'longitude': prettyAddress.longitude,
    };

    return prettyAddressMap;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> prettyAddressMap = {
      'address': prettyAddress.address,
      'city': prettyAddress.city,
      'country': prettyAddress.country,
      'countryCode': prettyAddress.countryCode,
      'postalCode': prettyAddress.postalCode,
      'state': prettyAddress.state,
      'stateCode': prettyAddress.stateCode,
      'streetNumber': prettyAddress.streetNumber,
      'streetName': prettyAddress.streetName,
      'placeId': prettyAddress.placeId,
      'latitude': prettyAddress.latitude,
      'longitude': prettyAddress.longitude,
    };

    return {
      'prettyAddress': prettyAddressMap,
      'formdata': formdata.toJson(),
      'user': user!.toJson(),
      'createdDate': DateTime.now(),
    };
  }

  static LocationModelFb fromJson(Map<String, dynamic> json) {
    GeocodingPrettyAddress mapToGeoPA(Map<String, dynamic> map) {
      return GeocodingPrettyAddress(
        address: map['address'] ?? '',
        city: map['city'] ?? '',
        country: map['country'] ?? '',
        postalCode: map['postalCode'] ?? '',
        streetName: map['streetName'] ?? '',
        placeId: map['placeId'] ?? '',
        countryCode: map['countryCode'] ?? '',
        streetNumber: map['streetNumber'] ?? '',
        state: map['state'] ?? '',
        stateCode: map['stateCode'] ?? '',
        latitude: map['latitude'],
        longitude: map['longitude'],
      );
    }

    DateTime? parseFirestoreTimestamp(Timestamp timestamp) {
      int seconds = timestamp.seconds;
      int nanoseconds = timestamp.nanoseconds;

      return DateTime.fromMillisecondsSinceEpoch(
              seconds * 1000 + (nanoseconds ~/ 1000000))
          .toLocal();
    }

    return LocationModelFb(
      prettyAddress: mapToGeoPA(json['prettyAddress']),
      user: UserDataModel.fromJson(json['user']),
      formdata: FormDataModel.fromJson(json['formdata']),
      createdDate: parseFirestoreTimestamp(json['createdDate']),
    );
  }
}

class FormDataModel {
  // ricetype: Oryza rhizomatis, city: Riligala, longitude: 80.13934739999999, postalCode: 60130, address: 94FQ+GPP, Riligala, Sri Lanka, latitude: 7.3738489, state: null

  String ricetype;
  String city;
  double longitude;
  String postalCode;
  String address;
  double latitude;
  String district;
  double length;
  double width;

  FormDataModel({
    required this.ricetype,
    required this.city,
    required this.longitude,
    required this.postalCode,
    required this.address,
    required this.latitude,
    required this.district,
    required this.length,
    required this.width,
  });

  Map<String, dynamic> toJson() {
    return {
      'ricetype': ricetype,
      'city': city,
      'longitude': longitude,
      'postalCode': postalCode,
      'address': address,
      'latitude': latitude,
      'district': district,
      'length': length,
      'width': width,
    };
  }

  static FormDataModel fromJson(Map<String, dynamic> json) {
    return FormDataModel(
      ricetype: json['ricetype'],
      city: json['city'],
      longitude: json['longitude'],
      postalCode: json['postalCode'],
      address: json['address'],
      latitude: json['latitude'],
      district: json['district'] ?? '',
      length: json['length'],
      width: json['width'],
    );
  }
}
