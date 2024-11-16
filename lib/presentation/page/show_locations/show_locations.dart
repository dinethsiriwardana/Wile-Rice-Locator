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
                if (state is GetAvaiableLocationsLoaded) {
                  final locations = state.locations;
                  return ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  locations[index].formdata.ricetype,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(locations[index].formdata.city),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(locations[index].formdata.address),
                                Text(locations[index].prettyAddress.stateCode),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(locations[index]
                                    .prettyAddress
                                    .latitude
                                    .toString()),
                                Text(locations[index]
                                    .prettyAddress
                                    .longitude
                                    .toString()),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
