import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//markerID,lat,lng,Location Name, Help Needed, Due Date, Name, Unit Number, Image, Details

class MapMoreInfo extends StatelessWidget {
  final String markerID;
  final double lat;
  final double lng;
  final String blkNum;
  final String helpNeeded;
  final String dueDate; //use Time class?
  final String unit;
  final String image;
  final String details;

  MapMoreInfo({
    required this.markerID,
    required this.lat,
    required this.lng,
    required this.blkNum,
    required this.helpNeeded,
    required this.dueDate,
    required this.unit,
    required this.image,
    required this.details,
  });

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Help Type
              //////////////CHILD//////////////////////
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image), //////////TEMP DEBUG
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              //////////////CHILD//////////////////////
              Container(
                child: (helpNeeded == "Groceries Needed")
                    ? groceryJellybean
                    : mealJellybean,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
              ),
              //////////////CHILD//////////////////////
              // Blk
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "Location: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "BLK $blkNum",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              ),
              //////////////CHILD//////////////////////
              // Due Date
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Needed By: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        child: 
                          Text(
                            DateFormat('dd MMM – kk:mm').format(DateTime.parse(dueDate)), 
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),


                  
              //
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "Details: ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width: MediaQuery.of(context).size.width,
                        child:  
                          Text(
                            details,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,),
                          ), 

                        ),
                  Padding(
                          padding: EdgeInsets.all(25),
                          child: ElevatedButton(
                            onPressed: (){},
                            child: Text(
                              "Accept",
                              style: TextStyle(fontSize: 30),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(250, 90),
                            ),
                          ),
                ),
                  ],
      
              ),
             
                ),            
            ]
          ),
        ),
      ),
    );
  }
}
