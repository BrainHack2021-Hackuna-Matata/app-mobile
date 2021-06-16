import 'dart:async';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './mapMoreInfo.dart';
import '../../api/static.dart';
import 'package:intl/intl.dart';
import './viewActiveCommit.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = Set();
  String selectedMarkerName = "No Location Selected";
  String selectedMarkerHelp = "";
  String selectedMarkerTime = "";
  String selectedMarkerId = "";
  int selectedMarkerIndex = 0;
  var markerData = [];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(1.3969420167883002, 103.74864029031227),
    zoom: 16,
  );

  @override
  initState() {
    super.initState();
    getinfo();
  }

  void getinfo() async {
    await http.get(Uri.parse('${Api.CURR_URL}/posts')).then((res) {
      var info = jsonDecode(res.body);
      List md = info.asMap().entries.map((entry) {
        int i = entry.key;
        var a = entry.value;
        return [
          'unique-marker${i + 1}',
          double.parse('${a['lat']}'),
          double.parse('${a['long']}'),
          '${a['location']}',
          '${a['title']}',
          '${a['due']}',
          '${a['owner']}',
          '${a['unit']}',
          'assets/purchase_default/groceries_default.jpg',
          '${a['description']}',
           a['id'],
           a['fulfilled'],
           a['accepted'],
          '${a['name']}',];

      }).toList();
      setState(() {
        markerData = md;
      });
    });
    print(markerData);
  }

  // List markerData = [
  //   [
  //     "unique-marker1",
  //     1.3708473245253212,
  //     103.8906930968424,
  //     "830A",
  //     "Groceries Needed",
  //     "17/06/21 8am",
  //     'Mr Tan',
  //     "#01-01",
  //     "assets/purchase_default/groceries_default.jpg",
  //     "I want the NTUC Sugar, then the salt must be the himalayan pink one ahh but the cheapest one that NTUC have because this one more expensive then also i need a new bottle of lao gan ma chilli but this one i think the ntuc here dont have can check if elsewhere have? this is my sons favourite and he is coming over for dinner on thursday I want to cook for him"
  //   ],
  //   [
  //     "unique-marker2",
  //     1.3719248384562128,
  //     103.88945871901747,
  //     "513",
  //     "Groceries Needed",
  //     "17/06/21 7am",
  //     'Mr Aziman',
  //     "#01-01",
  //     "assets/purchase_default/groceries_default.jpg",
  //     "I Ran out Of rice. Please help me to buy 1x Basmanthi rice. Any size will do. I do not want to Trouble you to carry it to my unit. Thank you very much."
  //   ],
  //   [
  //     "unique-marker3",
  //     1.3714236478236796,
  //     103.89026552566038,
  //     "831",
  //     "Meal Needed",
  //     "17/06/21 10am",
  //     'Mdm Chong',
  //     "#01-01",
  //     "assets/purchase_default/meal_default.jpg",
  //     "Cai Png, 1 egg, xiao bai cai and curry sauce"
  //   ],
  // ];
//markerID,lat,lng,Blk Num, Help Needed, Due Date, Name, Unit Number, Image, Details
  Widget groceryJellybean = Text("Groceries Needed",
      style: TextStyle(
          fontSize: 36,
          backgroundColor: Colors.blue[200],
          color: Colors.blue[50]));
  Widget mealJellybean = Text("Meal Needed",
      style: TextStyle(
          fontSize: 36,
          backgroundColor: Colors.orange[200],
          color: Colors.orange[50]));

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < markerData.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(markerData[i][0]),
          position: LatLng(markerData[i][1], markerData[i][2]),
          infoWindow: InfoWindow(
              title: "BLK " + markerData[i][3], snippet: markerData[i][4]),
          onTap: () {
            setState(() {
              selectedMarkerName = markerData[i][3];
              selectedMarkerHelp = markerData[i][4];
              selectedMarkerTime = markerData[i][5];
              selectedMarkerId = markerData[i][0];
              selectedMarkerIndex = i;
            });
          }));
    }

    return new Scaffold(
        appBar: AppBar(
        title: Text("Groupbuy"),
      ),
        body: SafeArea(
        child: Column(children: <Widget>[
      Stack(children: <Widget>[
          Container(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: markers,
              mapToolbarEnabled: false,
            ),
            constraints: BoxConstraints.tightFor(
                height: MediaQuery.of(context).size.height * 0.6),
          )
      ]),
      Spacer(),
      (selectedMarkerName == "No Location Selected")
            ? Text(selectedMarkerName,
                style: TextStyle(
                  fontSize: 26,
                ))
            : Text("BLK " + selectedMarkerName,
                style: TextStyle(
                  fontSize: 26,
                )),
      (selectedMarkerHelp == "Groceries Needed")
            ? groceryJellybean
            : (selectedMarkerHelp == "Meal Needed")
                ? mealJellybean
                : SizedBox(height: 1),
      (selectedMarkerTime == '')
      ? Text('')
      : Text(DateFormat('dd MMM').format(DateTime.parse(selectedMarkerTime)),
            style: TextStyle(
              fontSize: 26,
            )),
      Row( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    textStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                onPressed: (selectedMarkerName == "No Location Selected")
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapMoreInfo(
                                      markerID: markerData[selectedMarkerIndex][0],
                                      lat: markerData[selectedMarkerIndex][1],
                                      lng: markerData[selectedMarkerIndex][2],
                                      blkNum: markerData[selectedMarkerIndex][3],
                                      helpNeeded: markerData[selectedMarkerIndex][4],
                                      dueDate: markerData[selectedMarkerIndex][5],
                                      unit: markerData[selectedMarkerIndex][7],
                                      image: markerData[selectedMarkerIndex][8],
                                      details: markerData[selectedMarkerIndex][9],
                                      
                                    )));
                      },
                child: (selectedMarkerName == "No Location Selected")
                    ? const Text('N/A')
                    : const Text('More Info')),
            SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    textStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                onPressed: (selectedMarkerName == "No Location Selected")
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewActiveCommit(                    
                                      lat: markerData[selectedMarkerIndex][1],
                                      long: markerData[selectedMarkerIndex][2],
                                      blkNum: markerData[selectedMarkerIndex][3],
                                      helpNeeded: markerData[selectedMarkerIndex][4],
                                      dueDate: markerData[selectedMarkerIndex][5],
                                      unit: markerData[selectedMarkerIndex][7],
                                      details: markerData[selectedMarkerIndex][9],
                                      id: markerData[selectedMarkerIndex][10],
                                      fulfilled: markerData[selectedMarkerIndex][11],
                                      accepted: markerData[selectedMarkerIndex][12],
                                      name: markerData[selectedMarkerIndex][13],
                                    )));
                      },
                child: (selectedMarkerName == "No Location Selected")
                    ? const Text('N/A')
                    : const Text('Accept')),
          ],
      ),
      SizedBox(height: 20),
    ]),
        ));
  }
}
