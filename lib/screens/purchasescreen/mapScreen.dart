import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import './mapMoreInfo.dart';
import '../../api/static.dart';
import '../../models/post.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<dynamic> posts = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await http.get(Uri.parse('${Api.CURR_URL}/posts')).then((res) {
      List array = jsonDecode(res.body);
      var formattedArray = array.map((a) {
        return Post(
          id: int.parse(a["id"]),
          title: a["title"],
          description: a["description"],
          location: a["location"],
          items: a["items"],
          imageurl: a["imageurl"],
          coming: a["coming"],
          owner: a["owner"],
          created: DateTime.parse(a["created"]),
          due: DateTime.parse(a["due"]),
          fulfilled: a["fulfilled"],
          accepted: a["accepted"],
          lat: double.parse(a["lat"]),
          long: double.parse(a["long"]),
          unit: a["unit"],
        );
      }).toList();
      setState(() {
        posts = formattedArray;
      });
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  String selectedMarkerName = "No Location Selected";
  String selectedMarkerHelp = "";
  String selectedMarkerTime = "";
  int selectedMarkerIndex = 0;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(1.3711723846449548, 103.89066901142144),
    zoom: 16,
  );

  Widget groceryJellybean = Text("Groceries Needed", style: TextStyle(fontSize: 36, backgroundColor: Colors.blue[200], color: Colors.blue[50]));
  Widget mealJellybean = Text("Meal Needed", style: TextStyle(fontSize: 36, backgroundColor: Colors.orange[200], color: Colors.orange[50]));

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < posts.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(posts[i].id),
          position: LatLng(posts[i].lat, posts[i].long),
          infoWindow: InfoWindow(title: "BLK " + posts[i].location, snippet: posts[i].title),
          onTap: () {
            setState(() {
              selectedMarkerName = posts[i].location;
              selectedMarkerHelp = posts[i].title;
              selectedMarkerTime = DateFormat('dd-MM-yyyy – kk:mm').format(posts[i].due);
              selectedMarkerIndex = i;
            });
          }));
    }

    return new Scaffold(
        appBar: AppBar(
          title: Text("Group Buy Requests"),
        ),
        body: Column(children: <Widget>[
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
              constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height * 0.6),
            )
          ]),
          Spacer(),
          (selectedMarkerName == "No Location Selected")
              ? Text(selectedMarkerName,
                  style: TextStyle(
                    fontSize: 24,
                  ))
              : Text("BLK " + selectedMarkerName,
                  style: TextStyle(
                    fontSize: 24,
                  )),
          (selectedMarkerHelp == "Groceries Needed")
              ? groceryJellybean
              : (selectedMarkerHelp == "Meal Needed")
                  ? mealJellybean
                  : SizedBox(height: 1),
          Text(selectedMarkerTime,
              style: TextStyle(
                fontSize: 24,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: (selectedMarkerName == "No Location Selected")
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapMoreInfo(
                                        markerID: posts[selectedMarkerIndex].id,
                                        lat: posts[selectedMarkerIndex].lat,
                                        lng: posts[selectedMarkerIndex].long,
                                        blkNum: posts[selectedMarkerIndex].location,
                                        helpNeeded: posts[selectedMarkerIndex].title,
                                        dueDate: posts[selectedMarkerIndex].due,
                                        name: "tan ah koo",
                                        unit: posts[selectedMarkerIndex].unit,
                                        image: posts[selectedMarkerIndex].imageurl,
                                        details: posts[selectedMarkerIndex].description,
                                      )));
                        },
                  child: (selectedMarkerName == "No Location Selected") ? const Text('N/A') : const Text('More Info')),
              SizedBox(width: 15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: (selectedMarkerName == "No Location Selected") ? null : () {},
                  child: (selectedMarkerName == "No Location Selected") ? const Text('N/A') : const Text('Accept')),
            ],
          ),
          SizedBox(height: 20),
        ]));
  }
}
