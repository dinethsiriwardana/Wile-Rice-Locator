import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wild_rice_locator/bloc/show_rice_data/show_rice_data_bloc.dart';
import 'package:wild_rice_locator/presentation/widgets/home/rice_nav.dart';

class RiceData extends StatefulWidget {
  final Map<String, dynamic> data;

  const RiceData({super.key, required this.data});

  @override
  State<RiceData> createState() => _RiceDataState();
}

class _RiceDataState extends State<RiceData> {
  List<String> _imagePaths = [];
  List<String> _imageExtensions = ['.jpeg'];

  Future<void> _loadImages(String folderName) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    setState(() {
      _imagePaths = manifestMap.keys
          .where((String key) =>
              _imageExtensions.any((ext) => key.endsWith(ext)) &&
              key.contains('assets/img/$folderName/'))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadImages(widget.data['codename']);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShowRiceDataBloc, ShowRiceDataState>(
      listener: (context, state) {
        if (state is ShowRiceDataLoaded) {
          // Trigger the image reload when the data changes
          _loadImages(state.data['codename']);
        }
      },
      child: SizedBox(
        height: 75.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SPECIES",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: buildJsonView(widget.data['species'], context),
              ),
              buildJsonView(widget.data, context),
              SizedBox(
                height: 300,
                width: 700,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
                  itemCount: _imagePaths.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Show image in a dialog when clicked
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Image.asset(_imagePaths[index]),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          _imagePaths[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildJsonView(dynamic data, BuildContext context) {
  if (data is Map<String, dynamic>) {
    final Map<String, dynamic> sorted_data = Map.fromEntries(
        data.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sorted_data.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: entry.key != "species"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      entry.key.replaceAll('_', ' ').toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: buildJsonView(entry.value, context),
                    ),
                  ],
                )
              : null,
        );
      }).toList(),
    );
  } else if (data is List) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.map((item) {
        return Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: buildJsonView(item, context),
        );
      }).toList(),
    );
  } else {
    return AutoSizeText(
      maxLines: 2,
      "- " + data.toString(),
      // style: TextStyle(fontSize: 16),
    );
  }
}
