import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wild_rice_locator/domain/model/firebase/location_model_fb.dart';
import 'package:wild_rice_locator/main.dart';

class ShowFullDetails extends StatefulWidget {
  final LocationModelFb locationModelFb;

  const ShowFullDetails({super.key, required this.locationModelFb});

  @override
  State<ShowFullDetails> createState() => _ShowFullDetailsState();
}

class _ShowFullDetailsState extends State<ShowFullDetails> {
  Future<void> _openGoogleMaps() async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${widget.locationModelFb.prettyAddress.latitude},${widget.locationModelFb.prettyAddress.longitude}';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  void _showLocationMap() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 80.w,
            height: 80.w,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        widget.locationModelFb.prettyAddress.latitude ?? 0,
                        widget.locationModelFb.prettyAddress.longitude ?? 0),
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('location'),
                      position: LatLng(
                          widget.locationModelFb.prettyAddress.latitude ?? 0,
                          widget.locationModelFb.prettyAddress.longitude ?? 0),
                      infoWindow: InfoWindow(title: 'Location'),
                    ),
                  },
                ),
                Container(
                  height: 50,
                  color: Colors.black.withOpacity(0.5),
                  child: InkWell(
                    onTap: _openGoogleMaps,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.gps_fixed_sharp,
                          color: Colors.white,
                        ),
                        Text(
                          "Set Direction",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.locationModelFb!.toJson());
    return Scaffold(
      appBar: AppBar(
        // back button
        title: const Text('Full Details'),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        child: FloatingActionButton(
          onPressed: _showLocationMap,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.gps_fixed_sharp),
              Text("See in Map"),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        width: 100.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: autosizeTexttext(
                    context, widget.locationModelFb.createdDate.toString()),
              ),
              const SizedBox(
                height: 30,
              ),
              AutoSizeText(
                'Location Details - User Inputs',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 5.8.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 80.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.locationModelFb.formdata
                      .toJson()
                      .entries
                      .map((entity) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        autosizeTextTitle(context, '${entity.key} '),
                        SizedBox(
                          height: 10,
                        ),
                        autosizeTexttext(context, '  - ${entity.value}'),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AutoSizeText(
                'Location Details - User Inputs',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 5.8.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 80.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.locationModelFb
                      .prettyAddressMaptoJson()
                      .entries
                      .map((entity) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        autosizeTextTitle(context, '${entity.key} '),
                        SizedBox(
                          height: 10,
                        ),
                        autosizeTexttext(context, '  - ${entity.value}'),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AutoSizeText(
                'Location Details - User Inputs',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 5.8.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 80.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.locationModelFb.user!
                      .toJson()
                      .entries
                      .map((entity) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        autosizeTextTitle(context, '${entity.key} '),
                        SizedBox(
                          height: 10,
                        ),
                        autosizeTexttext(context, '  - ${entity.value}'),
                      ],
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  AutoSizeText autosizeTextTitle(BuildContext context, String text) {
    return AutoSizeText(
      text[0].toUpperCase() + text.substring(1),
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  AutoSizeText autosizeTexttext(BuildContext context, String text) {
    return AutoSizeText(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
