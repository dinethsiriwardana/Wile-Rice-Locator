import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wild_rice_locator/bloc/get_avaiable_locations/get_avaiable_locations_bloc.dart';
import 'package:wild_rice_locator/main.dart';

class ShowLocations extends StatefulWidget {
  const ShowLocations({super.key});

  @override
  State<ShowLocations> createState() => _ShowLocationsState();
}

class _ShowLocationsState extends State<ShowLocations> {
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
                      String cleanedAddress = locations[index].formdata.address;
                      cleanedAddress =
                          cleanedAddress.replaceAll(", Sri Lanka", ".");

                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/ShowFullDetails',
                              arguments: {'locationModelFb': locations[index]});
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          height: 100,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 80.w,
                                    child: AutoSizeText(
                                      maxLines: 2,
                                      cleanedAddress,
                                    ),
                                  ),
                                  Text(
                                      locations[index].prettyAddress.stateCode),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
