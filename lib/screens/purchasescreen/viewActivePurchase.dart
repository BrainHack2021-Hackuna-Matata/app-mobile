import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api/static.dart';
//markerID,lat,lng,Location Name, Help Needed, Due Date, Name, Unit Number, Image, Details

class ViewActivePurchase extends StatelessWidget {
  final int id;
  final String blkNum;
  final String helpNeeded;
  final String dueDate; //use Time class?
  final String name;
  final String unit;
  final String details;
  final bool accepted;
  final bool fulfilled;

  final Function refreshSplashScreen;

  ViewActivePurchase({
    required this.id,
    required this.blkNum,
    required this.helpNeeded,
    required this.dueDate,
    required this.name,
    required this.unit,
    required this.details,
    required this.accepted,
    required this.fulfilled,
    required this.refreshSplashScreen,
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

  Widget waitingJellybean = Text("Pending Accept",
      style: TextStyle(
          fontSize: 36,
          backgroundColor: Colors.yellow[200],
          color: Colors.black));

  Widget acceptedJellybean = Text("Accepted",
      style: TextStyle(
          fontSize: 36,
          backgroundColor: Colors.green[200],
          color: Colors.green[50]));

  Widget fulfilledJellybean = Text("Fulfilled",
      style: TextStyle(
          fontSize: 36,
          backgroundColor: Colors.purple[200],
          color: Colors.purple[50]));

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
                    image: AssetImage(
                        'assets/purchase_default/groceries_default.jpg'), //////////TEMP DEBUG
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
                      child: Text(
                        dueDate, /////////////////////////////////////to be changed to time format
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Name
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Requestee: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Details
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
                child: Text(
                  details,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              //////////////CHILD//////////////////////
              Container(
                child: (accepted == true)
                    ? (fulfilled == true)
                        ? fulfilledJellybean
                        : acceptedJellybean
                    : waitingJellybean,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: ElevatedButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Cancellation',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                content: const Text(
                                  'Are you sure you want to cancel this request? It cannot be undone!',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context, 'Yes');
                                      await http.delete(Uri.parse(
                                          '${Api.CURR_URL}/posts/${id}'));
                                      refreshSplashScreen();
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'No'),
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  )
                                ]));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 90), primary: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
