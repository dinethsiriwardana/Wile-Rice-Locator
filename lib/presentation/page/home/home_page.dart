import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wild_rice_locator/bloc/fetch_data/fetch_data_bloc.dart';
import 'package:wild_rice_locator/bloc/show_rice_data/show_rice_data_bloc.dart';
import 'package:wild_rice_locator/main.dart';
import 'package:wild_rice_locator/presentation/widgets/home/rice_details.dart';
import 'package:wild_rice_locator/presentation/widgets/home/rice_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: Theme.of(context).primaryColor,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        switchLabelPosition: true,
        // childrenButtonSize: Size(70.0, 70.0),
        // buttonSize: Size(70.0, 70.0),
        spacing: 20.0,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.gps_fixed,
              size: 40,
            ),
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            label: '  Add Locations  ',
            visible: true,
            onTap: () => Navigator.pushNamed(context, '/addlocation'),
            onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.search,
              size: 40,
            ),
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            label: '  Search Locations  ',
            visible: true,
            onTap: () => Navigator.pushNamed(context, '/showlocations'),
            onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.map,
              size: 40,
            ),
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            label: '  See Map  ',
            visible: true,
            onTap: () => Navigator.pushNamed(context, '/allMap'),
            onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
          ),
        ],
      ),

      //  SizedBox(
      //   width: 170, // Adjust the width here
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       // Handle button press
      //       Navigator.pushNamed(context, '/addlocation');
      //     },
      //     child: const Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Icon(Icons.add),
      //         SizedBox(width: 8), // Space between icon and text
      //         Text('Add a Location'),
      //       ],
      //     ),
      //   ),
      // ),
      body: BlocBuilder(
        bloc: BlocProvider.of<FetchDataBloc>(context),
        builder: (context, state) {
          if (state is FetchDataLoading) {
            return const CircularProgressIndicator();
          } else if (state is FetchDataLoaded) {
            final data = state.data;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RiceNavBar(data: data),
                    Container(
                      height: 98.h,
                      width: 70.w,
                      padding: const EdgeInsets.all(10),
                      color: Theme.of(context).primaryColorLight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              AutoSizeText(
                                maxLines: 1,
                                'Wild Rice',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              AutoSizeText(
                                'Locator',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              BlocBuilder(
                                  bloc: BlocProvider.of<ShowRiceDataBloc>(
                                      context),
                                  builder: (context, state) {
                                    if (state is ShowRiceDataLoaded) {
                                      return RiceData(data: state.data);
                                    } else {
                                      return const Column(
                                        children: [
                                          AutoSizeText(
                                              textAlign: TextAlign.justify,
                                              // maxLines: 10,
                                              "The app we’re developing is designed to help users identify, document, and locate different types of wild rice native to Sri Lanka. The app will feature a comprehensive catalog of wild rice species found across the island, allowing users to explore detailed profiles for each type. These profiles will include high-resolution images, and descriptions to aid in accurate identification."
                                              // style: TextStyle(fontSize: 16),
                                              )
                                        ],
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
