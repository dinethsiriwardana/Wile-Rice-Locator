import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wild_rice_locator/bloc/get_avaiable_locations/get_avaiable_locations_bloc.dart';

class ShowLocations extends StatefulWidget {
  const ShowLocations({super.key});

  @override
  State<ShowLocations> createState() => _ShowLocationsState();
}

class _ShowLocationsState extends State<ShowLocations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder(
              bloc: BlocProvider.of<GetAvaiableLocationsBloc>(context),
              builder: (context, state) {
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
