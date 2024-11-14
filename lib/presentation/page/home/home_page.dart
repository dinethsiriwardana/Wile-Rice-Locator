import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      floatingActionButton: SizedBox(
        width: 170, // Adjust the width here
        child: FloatingActionButton(
          onPressed: () {
            // Handle button press
            print('FAB Pressed');
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 8), // Space between icon and text
              Text('Add a Location'),
            ],
          ),
        ),
      ),
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
                      height: 88.h,
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
                                    }
                                    return const SizedBox();
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
