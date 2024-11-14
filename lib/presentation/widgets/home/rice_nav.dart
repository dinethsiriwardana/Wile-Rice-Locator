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
    return Container(
      height: 67.h,
      width: 23.w,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          // foreach for data

          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];

                return InkWell(
                  onTap: () {
                    ricenav.add(ShowRiceData(item));
                  },
                  child: Container(
                    height: 18.w,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/img/${item['codename']}/icon.png'),
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
    );
  }
}
