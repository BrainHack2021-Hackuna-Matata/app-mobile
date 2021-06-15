import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(1.3711723846449548, 103.89066901142144),
    zoom: 16,
  );  
  
List markerData = [["unique-marker1",1.3708473245253212, 103.8906930968424,"Blk 830A","Groceries Needed","17/06/21 8am"],
                  ["unique-marker2",1.3719248384562128, 103.88945871901747,"Blk 513","Groceries Needed","17/06/21 7am"],
                  ["unique-marker3",1.3714236478236796, 103.89026552566038,"Blk 831","Meal Needed","17/06/21 10am"],];

  @override
  Widget build(BuildContext context) {
     for(var i=0;i<markerData.length;i++){
      markers.add(
      Marker(
      markerId: MarkerId(markerData[i][0]),
      position: LatLng(markerData[i][1], markerData[i][2]),
      infoWindow: InfoWindow(
        title: markerData[i][3],
        snippet: markerData[i][4]
      ),
      onTap:(){
        setState((){selectedMarkerName = markerData[i][3];
        selectedMarkerHelp = markerData[i][4];
        selectedMarkerTime = markerData[i][5];
        selectedMarkerId = markerData[i][0];
        });
      })
      );
     }

    return new Scaffold(
      body: Column(children: <Widget>[
      Stack(
        children:<Widget>[
      Container(child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers:markers,
        mapToolbarEnabled: false,
      ),
      constraints: BoxConstraints.tightFor(height : MediaQuery.of(context).size.height*0.6 ),)
        ]),
      Spacer(),
      Text(selectedMarkerName, style: TextStyle(
              fontSize: 36,)),
      Text(selectedMarkerHelp, style: TextStyle(
              fontSize: 36,)),
      Text(selectedMarkerTime, style: TextStyle(
              fontSize: 36,)),
       ElevatedButton(
            style: ElevatedButton.styleFrom(
      primary: Colors.green, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            onPressed: (selectedMarkerName == "No Location Selected")
            ? null
            : () {},
            child: (selectedMarkerName == "No Location Selected")
            ? const Text('N/A')
            : const Text('Contact')
    ),
    SizedBox(height: 20),
    ]));
  }
}