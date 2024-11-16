import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wild_rice_locator/bloc/get_location/getlocation_bloc.dart';
import 'package:wild_rice_locator/data/firebase_service/location.dart';
import 'package:wild_rice_locator/domain/model/firebase/location_model_fb.dart';
import 'package:wild_rice_locator/domain/model/local/location_model.dart';
import 'package:wild_rice_locator/main.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  GoogleMapController? mapController;
  final _formKey = GlobalKey<FormState>();
  String? postalCode, city, state, address, area, length, width;
  double? latitude, longitude;
  String? ricetype = null; // Explicitly set to null

  final List<String> ricestype = [
    "Oryza nivara",
    "Oryza rufipogon",
    "Oryza rhizomatis",
    "Oryza granulata",
    "Oryza eichingeri"
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> submit(GeocodingPrettyAddress prettyAddress) async {
    final location = LocationModelFb(
      prettyAddress: prettyAddress,
      formdata: FormDataModel(
        address: address ?? '',
        postalCode: postalCode ?? '',
        city: city ?? '',
        district: state ?? '',
        latitude: prettyAddress.latitude,
        longitude: prettyAddress.longitude,
        ricetype: ricetype ?? '',
        length: 0,
        width: 0,
      ),
    );

    Map<String, String> resutl = await LocationHandler().addLocation(location);

    if (resutl['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          // backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          elevation: 10,
          content: Text('Location added successfully'),
        ),
      );
      // pop
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          // backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          elevation: 10,
          content: Text('Location added successfully'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final getlocation = BlocProvider.of<GetlocationBloc>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            width: 100.w,
            height: 80.h,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: BlocBuilder(
                bloc: BlocProvider.of<GetlocationBloc>(context),
                builder: (context, state) {
                  if (state is GetlocationLoading) {
                    return const Center(
                      child: SizedBox(
                          height: 100,
                          width: 200,
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text('Locating....'),
                            ],
                          )),
                    );
                  } else if (state is GetlocationLoaded) {
                    final location = state.location;
                    return SingleChildScrollView(
                      child: Center(
                        child: Container(
                          // height: 80.h,
                          padding: const EdgeInsets.all(10),
                          width: 90.w,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: 'Rice Type',
                                    border: OutlineInputBorder(),
                                    labelStyle: TextStyle(fontSize: 16.0),
                                  ),
                                  isExpanded: true,
                                  hint: const Text('Select the type of rice'),
                                  value:
                                      ricetype, // This is now explicitly null at start
                                  items: ricestype.map((String district) {
                                    return DropdownMenuItem<String>(
                                      value: district,
                                      child: Text(district),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please the type of rice';
                                    }
                                    return null;
                                  },
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      ricetype = newValue;
                                    });
                                  },
                                ),
                                buildTextFormField('Address', 'Enter Address',
                                    (value) => address = value,
                                    initialValue:
                                        location.prettyAddress.address),
                                buildTextFormField(
                                    'Postal Code',
                                    'Enter Postal Code',
                                    (value) => postalCode = value),
                                buildTextFormField(
                                  'City',
                                  'Enter City',
                                  (value) => city = value,
                                  initialValue: location.prettyAddress.city,
                                ),
                                buildTextFormField(
                                  'Length',
                                  'Enter length',
                                  (value) => length = value,
                                ),
                                buildTextFormField(
                                  'Width',
                                  'Enter width',
                                  (value) => width = value,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 90.w,
                                  width: 90.w,
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          location.prettyAddress.latitude,
                                          location.prettyAddress.longitude),
                                      zoom: 12.0,
                                    ),
                                    markers: location.getMarkers,
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: true,
                                    onTap: (LatLng latLng) async {
                                      try {
                                        Position tappedPosition = Position(
                                          latitude: latLng.latitude,
                                          longitude: latLng.longitude,
                                          timestamp: DateTime.now(),
                                          accuracy: 0,
                                          altitude: 0,
                                          heading: 0,
                                          speed: 0,
                                          speedAccuracy: 0,
                                          altitudeAccuracy: 0,
                                          headingAccuracy: 0,
                                        );
                                        print(tappedPosition);
                                        getlocation.add(
                                            UpdateLocation(tappedPosition));
                                      } catch (e) {
                                        print(
                                            "Error getting address for tapped location: $e");
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 90.w,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        submit(location.prettyAddress);
                                      }
                                    },
                                    child: const Text("Submit"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Text('Error getting location');
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextFormField(
      String label, String hint, Function(String?) onSaved,
      {String? initialValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        style: const TextStyle(fontSize: 16.0),
        cursorHeight: 30,
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontSize: 16.0),
          labelStyle: const TextStyle(fontSize: 16.0),
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        onSaved: (value) => onSaved(value),
      ),
    );
  }

  Widget buildNumberFormField(
      String label, String hint, Function(String?) onSaved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: const TextStyle(fontSize: 16.0),
        cursorHeight: 30,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontSize: 16.0),
          labelStyle: const TextStyle(fontSize: 16.0),
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value!.isEmpty || double.tryParse(value) == null) {
            return 'Please enter a valid $label';
          }
          return null;
        },
        onSaved: (value) => onSaved(value),
      ),
    );
  }
}
