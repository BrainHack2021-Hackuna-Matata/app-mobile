import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

import './mapMoreInfo.dart';
import './viewActiveCommit.dart';
import '../../api/static.dart';

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
          '${a['name']}',
        ];
      }).toList();
      setState(() {
        markerData = md;
      });
    });
  }

//markerID,lat,lng,Blk Num, Help Needed, Due Date, Name, Unit Number, Image, Details
  Widget groceryJellybean = Text("Groceries Needed", style: TextStyle(fontSize: 36, backgroundColor: Colors.blue[200], color: Colors.blue[50]));
  Widget mealJellybean = Text("Meal Needed", style: TextStyle(fontSize: 36, backgroundColor: Colors.orange[200], color: Colors.orange[50]));

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < markerData.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(markerData[i][0]),
          position: LatLng(markerData[i][1], markerData[i][2]),
          infoWindow: InfoWindow(title: "BLK " + markerData[i][3], snippet: markerData[i][4]),
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
        title: Text("GroupBuy"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
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
                  constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height * 0.6),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      (selectedMarkerName == "No Location Selected")
                          ? Text(markerData.length == 0 ? "No requests at this time" : "Please select a location",
                              style: TextStyle(
                                fontSize: 26,
                              ))
                          : Text(
                              "BLK " + selectedMarkerName,
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                      (selectedMarkerTime == '')
                          ? Text('')
                          : Text(
                              DateFormat('dd MMM').format(DateTime.parse(selectedMarkerTime)),
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                    ],
                  ),
                  (selectedMarkerHelp == "Groceries Needed")
                      ? groceryJellybean
                      : (selectedMarkerHelp == "Meal Needed")
                          ? mealJellybean
                          : SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: selectedMarkerId == ""
                        ? [SizedBox(height: 50)]
                        : [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                                onPressed: () {
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
                                child: const Text('More Info')),
                            SizedBox(width: 20),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    textStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                                onPressed: () {
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
                                                getinfo: getinfo,
                                              ))).then((res) {
                                    getinfo();
                                  });
                                },
                                child: const Text('Accept')),
                          ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
