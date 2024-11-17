import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wild_rice_locator/bloc/get_avaiable_locations/get_avaiable_locations_bloc.dart';
import 'package:wild_rice_locator/main.dart';

class AllMap extends StatefulWidget {
  const AllMap({super.key});

  @override
  State<AllMap> createState() => _AllMapState();
}

class _AllMapState extends State<AllMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Locations'),
        // backbutton
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          BlocBuilder(
              bloc: BlocProvider.of<GetAvaiableLocationsBloc>(context)
                ..add(GetAvaiableLocationsMap()),
              builder: (context, state) {
                if (state is GetAvaiableLocationsMapLoaded) {
                  return GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(7.819889978101181, 80.74995010219125),
                      zoom: 8,
                    ),
                    markers: state.markers,
                    padding: EdgeInsets.only(bottom: 30),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
          Positioned(
            bottom: 50,
            left: 10,
            child: Container(
              // width: 20.w,
              // height: 200,
              padding: const EdgeInsets.all(10),
              color: Colors.white.withOpacity(0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem('Nivara', Colors.blue),
                  _buildLegendItem('Rufipogon', Colors.brown),
                  _buildLegendItem('Rhizomatis', Colors.red),
                  _buildLegendItem('Granulata', Colors.purple),
                  _buildLegendItem('Eichingeri', Colors.yellow),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String ricetype, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            ricetype,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
