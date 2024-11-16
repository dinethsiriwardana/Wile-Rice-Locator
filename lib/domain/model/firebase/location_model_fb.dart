import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:wild_rice_locator/domain/model/firebase/user_model.dart';

class LocationModelFb {
  GeocodingPrettyAddress prettyAddress;
  UserDataModel? user;
  Map<String, dynamic> formdata;

  LocationModelFb(
      {required this.prettyAddress, this.user, required this.formdata});

  Map<String, dynamic> toJson() {
    // Conver this to a Map
//     prettyAddress: GeocodingPrettyAddress(
// address=94FQ+GPP, Riligala, Sri Lanka
// city=Riligala
// country=Sri Lanka
// countryCode=LK
// postalCode=
// state=North Western Province
// stateCode=NW
// streetNumber=
// streetName=
// placeId=ChIJs13hEf8g4zoRR0z4kKtUcnA
// )

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
    };

    return {
      'prettyAddress': prettyAddressMap,
      'formdata': formdata,
      'user': user!.toJson(),
    };
  }

  static LocationModelFb fromJson(Map<String, dynamic> json) {
    return LocationModelFb(
      prettyAddress: json['prettyAddress'],
      user: json['user'],
      formdata: json['formdata'],
    );
  }
}
