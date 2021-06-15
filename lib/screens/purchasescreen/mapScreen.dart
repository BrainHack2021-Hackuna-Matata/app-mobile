import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './mapMoreInfo.dart';


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

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(1.3711723846449548, 103.89066901142144),
    zoom: 16,
  );  
  
List markerData = [["unique-marker1",1.3708473245253212, 103.8906930968424,"830A","Groceries Needed","17/06/21 8am",'Mr Tan',"#01-01", "assets/purchase_default/groceries_default.jpg",
                  "I want the NTUC Sugar, then the salt must be the himalayan pink one ahh but the cheapest one that NTUC have because this one more expensive then also i need a new bottle of lao gan ma chilli but this one i think the ntuc here dont have can check if elsewhere have? this is my sons favourite and he is coming over for dinner on thursday I want to cook for him"],
                  ["unique-marker2",1.3719248384562128, 103.88945871901747,"513","Groceries Needed","17/06/21 7am",'Mr Aziman',"#01-01", "assets/purchase_default/groceries_default.jpg",
                  "I Ran out Of rice. Please help me to buy 1x Basmanthi rice. Any size will do. I do not want to Trouble you to carry it to my unit. Thank you very much."],
                  ["unique-marker3",1.3714236478236796, 103.89026552566038,"831","Meal Needed","17/06/21 10am",'Mdm Chong',"#01-01", "assets/purchase_default/meal_default.jpg",
                  "Cai Png, 1 egg, xiao bai cai and curry sauce"],];
//markerID,lat,lng,Blk Num, Help Needed, Due Date, Name, Unit Number, Image, Details
Widget groceryJellybean = Text("Groceries Needed",style: TextStyle(
              fontSize: 36, backgroundColor: Colors.blue[200] , color: Colors.blue[50] ));
Widget mealJellybean = Text("Meal Needed",style: TextStyle(
              fontSize: 36, backgroundColor: Colors.orange[200] , color: Colors.orange[50] ));
          

  @override
  Widget build(BuildContext context) {
     for(var i=0;i<markerData.length;i++){
      markers.add(
      Marker(
      markerId: MarkerId(markerData[i][0]),
      position: LatLng(markerData[i][1], markerData[i][2]),
      infoWindow: InfoWindow(
        title: "BLK " + markerData[i][3],
        snippet: markerData[i][4]
      ),
      onTap:(){
        setState((){selectedMarkerName = markerData[i][3];
        selectedMarkerHelp = markerData[i][4];
        selectedMarkerTime = markerData[i][5];
        selectedMarkerId = markerData[i][0];
        selectedMarkerIndex = i;
        });
      })
      );
     }

    return new Scaffold(
      appBar: AppBar(
        title: Text("Group Buy Requests"),
      ),
      body: Column(children: <Widget>[
      Stack(
        children:<Widget>[
      Container(child: GoogleMap(
        mapType: MapType.normal,
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
      (selectedMarkerName == "No Location Selected")
      ?  Text(selectedMarkerName, style: TextStyle(
              fontSize: 24,))
      : Text("BLK " + selectedMarkerName, style: TextStyle(
              fontSize: 24,)),      
      (selectedMarkerHelp == "Groceries Needed")
      ? groceryJellybean
      : (selectedMarkerHelp == "Meal Needed")
      ? mealJellybean
      : SizedBox(height: 1),
      Text(selectedMarkerTime, style: TextStyle(
              fontSize: 24,)),
       Row(
         mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
         children: [
           ElevatedButton(
                style: ElevatedButton.styleFrom( primary: Colors.blue,
           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                onPressed: (selectedMarkerName == "No Location Selected")
                ? null
                : (){Navigator.push(context,
                MaterialPageRoute(builder: (context) => MapMoreInfo(
                  markerID: markerData[selectedMarkerIndex][0],
                  lat: markerData[selectedMarkerIndex][1] ,
                  lng: markerData[selectedMarkerIndex][2],
                  blkNum: markerData[selectedMarkerIndex][3] ,
                  helpNeeded: markerData[selectedMarkerIndex][4],
                  dueDate: markerData[selectedMarkerIndex][5] ,
                  name: markerData[selectedMarkerIndex][6],
                  unit: markerData[selectedMarkerIndex][7],
                  image: markerData[selectedMarkerIndex][8] ,
                  details: markerData[selectedMarkerIndex][9],
                )));
                },
                child: (selectedMarkerName == "No Location Selected")
                ? const Text('N/A')
                : const Text('More Info')
    ), 
        SizedBox(width: 15),
       ElevatedButton(
                style: ElevatedButton.styleFrom(
           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                onPressed: (selectedMarkerName == "No Location Selected")
                ? null
                : (){},
                child: (selectedMarkerName == "No Location Selected")
                ? const Text('N/A')
                : const Text('Accept')
    ), 
         ],
       ),
    SizedBox(height: 20),
    ]));
  }


}