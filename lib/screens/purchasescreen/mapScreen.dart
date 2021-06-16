import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

import './mapMoreInfo.dart';
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
    target: LatLng(1.3711723846449548, 103.89066901142144),
    zoom: 16,
  );

  @override
  initState() {
    getinfo();
    super.initState();
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
          '${a['description']}'
        ];
      }).toList();
      setState(() {
        markerData = md;
      });
    });
  }

//markerID,lat,lng,Blk Num, Help Needed, Due Date, Name, Unit Number, Image, Details
  Widget groceryJellybean = Text("Groceries Needed", style: TextStyle(fontSize: 30, backgroundColor: Colors.blue[200], color: Colors.blue[50]));
  Widget mealJellybean = Text("Meal Needed", style: TextStyle(fontSize: 30, backgroundColor: Colors.orange[200], color: Colors.orange[50]));

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < markerData.length; i++) {
      markers.add(
        Marker(
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
          },
        ),
      );
    }

    return new Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: markers,
                  mapToolbarEnabled: false,
                ),
                constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height * 0.7),
              )
            ],
          ),
          Spacer(),
          (selectedMarkerName == "No Location Selected")
              ? Text(
                  selectedMarkerName,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              : Text(
                  selectedMarkerName,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
          (selectedMarkerHelp == "Groceries Needed")
              ? groceryJellybean
              : (selectedMarkerHelp == "Meal Needed")
                  ? mealJellybean
                  : SizedBox(height: 1),
          Text(
            DateFormat("MMM dd  hh:mm aa").format(DateTime.parse(selectedMarkerTime)),
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
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
                            name: markerData[selectedMarkerIndex][6],
                            unit: markerData[selectedMarkerIndex][7],
                            image: markerData[selectedMarkerIndex][8],
                            details: markerData[selectedMarkerIndex][9],
                          ),
                        ),
                      );
                    },
              child: (selectedMarkerName == "No Location Selected") ? const Text('N/A') : const Text('More Info')),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
