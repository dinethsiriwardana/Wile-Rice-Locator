import 'package:cloud_firestore/cloud_firestore.dart';

class RiceData {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveRiceData() async {
    List<Map<String, dynamic>> data = [
      {
        "species": "Oryza nivara",
        "common_name": "Wild Rice",
        "distribution": {
          "dry_zone": [
            "Hambantota",
            "Monaragala",
            "Badulla",
            "Ampara",
            "Batticaloa",
            "Anuradhapura",
            "Polonnaruwa",
            "Puttalam",
            "Mannar",
            "Kilinochchi"
          ],
          "intermediate_zone": ["Monaragala", "Badulla", "Matale", "Kurunegala"]
        },
        "habitat": [
          "Lakes and lakesides",
          "Swampy areas",
          "Streams",
          "Irrigation canal boundaries in paddy fields",
          "Roadside areas and ditches"
        ],
        "life_cycle": {
          "type": "Annual plant",
          "germination":
              "Rainfall-dependent, germinates at start of rainy season, completes life cycle in dry period",
          "flowering_period":
              "December to July, peak from January to May; some locations August to December"
        },
        "morphology": {
          "growth_form": "Erect to semi-erect, < 2 m",
          "panicles": "Frequently compact",
          "spikelets": {"length": "6-10.4 mm", "width": "1.9-3.4 mm"},
          "awns": "4–10 cm, red at maturity",
          "anthers": "Cream, 1.5–3 mm",
          "stigma": "Purple",
          "tillering": "Varies from poor to very high"
        }
      },
      {
        "species": "Oryza rufipogon",
        "common_name": "Wild Rice",
        "distribution": "Widely distributed in Wet Zone",
        "habitat": [
          "Deep water bodies (30 cm to 5 m)",
          "Irrigation canals",
          "Lakes",
          "Ditches",
          "Swamps",
          "Marshy land"
        ],
        "life_cycle": {
          "type": "Perennial plant",
          "flowering_period":
              "December to January, some populations in August; ceases by March end"
        },
        "morphology": {
          "growth_form": "Tufted, scrambling, nodal tillering",
          "height": "1-5 m",
          "panicles": "Open form",
          "spikelets": {"length": "4.5-10.6 mm", "width": "1.6-3.5 mm"},
          "awns": "4–10 cm, straw yellow to brick red",
          "anthers": "> 3 mm, straw-colored",
          "stigma": "Dark purple"
        }
      },
      {
        "species": "Oryza granulata",
        "common_name": "Wild Rice",
        "distribution": "Intermediate zone",
        "habitat": [
          "Shaded or partially shaded areas in degraded primary/secondary forests",
          "Well-drained soils",
          "Forests",
          "Streams",
          "Limestone surfaces",
          "Under forest canopy with abundant soil moisture"
        ],
        "life_cycle": {
          "type": "Perennial plant",
          "phenology": "Year-round flowering and growth"
        },
        "morphology": {
          "growth_form": "Erect, loosely tufted or solitary",
          "height": "40-90 cm",
          "leaves": {
            "length": "10-25 cm",
            "width": "1-2 cm",
            "surface": "Glabrous with long hairs at sheath mouth"
          },
          "panicles": "5-10 cm, compact with few branches",
          "spikelets": "Less than 6.4 mm, awnless, 5-6 per panicle",
          "anther_and_stigma": "White"
        }
      },
      {
        "species": "Oryza eichingeri",
        "common_name": "Wild Rice",
        "distribution": "Intermediate and dry mixed evergreen forests",
        "habitat": [
          "Partially shaded and open areas",
          "Well-drained locations",
          "Forest edges",
          "Roadside areas",
          "Forest borders"
        ],
        "life_cycle": {
          "type": "Annual plant",
          "phenology": "Year-round growth and flowering"
        },
        "morphology": {
          "growth_form": "Erect annual grass",
          "height": "60-120 cm",
          "leaf_blades": {"length": "Up to 30 cm", "width": "1 cm"},
          "ligule": "Whitish, 3-10 mm",
          "anthers_and_stigma": "Light yellow",
          "panicles": "Spreading branches"
        }
      },
      {
        "species": "Oryza rhizomatis",
        "common_name": "Wild Rice",
        "distribution": "Dry zone low country",
        "habitat": [
          "Periodically flooded areas",
          "Open or partially shaded areas",
          "Seasonally dry habitats at low forest edges",
          "Marshy areas",
          "Lake banks"
        ],
        "life_cycle": {
          "type": "Perennial grass (hemicryptophyte)",
          "phenology": "December to May"
        },
        "morphology": {
          "growth_form": "Erect or semi-erect",
          "height": "1.2-1.5 m",
          "roots": "Adventitious roots and branched rhizomes",
          "leaves": {"length": "1.8-2.9 cm", "width": "13-18 mm"},
          "anthers_and_stigma": "Purple",
          "panicles": "Open, spreading branches, purple",
          "spikelets": "Highly shattering, dark"
        }
      }
    ];
    try {
      // run a loop
      for (var i = 0; i < data.length; i++) {
        await db
            .collection('wildrice')
            .doc(data[i]['species'].replaceAll(' ', '').toLowerCase())
            .set(data[i]);
      }
    } catch (e) {
      print('Error saving rice data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getRiceData() async {
    try {
      QuerySnapshot querySnapshot = await db.collection('wildrice').get();
      // querySnapshot.docs.forEach((doc) {
      //   print(doc.data());
      // });
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw ('Error getting rice data: $e');
    }
  }
}
