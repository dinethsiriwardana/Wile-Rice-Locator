import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wild_rice_locator/bloc/show_rice_data/show_rice_data_bloc.dart';
import 'package:wild_rice_locator/presentation/page/home/home_page.dart';

class RiceNavBar extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const RiceNavBar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ricenav = context.read<ShowRiceDataBloc>();
    int nav = 0;
    return SizedBox(
      height: 100.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 67.h,
            width: 23.w,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Add home icon
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    shrinkWrap:
                        true, // Makes ListView take only the needed space
                    physics:
                        const NeverScrollableScrollPhysics(), // Disables scrolling
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var item = data[index];
                      return InkWell(
                        onTap: () {
                          if (nav == index) {
                            ricenav.add(ShowAppData());
                            nav = -1;
                          } else {
                            nav = index;
                            ricenav.add(ShowRiceData(item));
                          }
                        },
                        child: Container(
                          height: 18.w,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/img/${item['codename']}/icon.jpeg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
