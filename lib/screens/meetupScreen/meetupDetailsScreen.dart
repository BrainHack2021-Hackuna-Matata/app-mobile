import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../models/user.dart';
import '../../components/notifier.dart';
import 'dart:convert';

import '../../components/notifier.dart';
import '../../api/static.dart';
import '../../models/meetup.dart';

class MeetupDetailsScreen extends StatefulWidget {
  final int id;

  MeetupDetailsScreen({
    required this.id,
  });

  @override
  _MeetupDetailsScreenState createState() => _MeetupDetailsScreenState();
}

class _MeetupDetailsScreenState extends State<MeetupDetailsScreen> {
  void selectMeetupHandler(
      {required int id, required int currentpax, required List attendees}) {
    //TODO pop dialogue screen to confirm and send it to
    //Call api to update participants and current pax
  }

  //meetup details
  Meetup md = Meetup(
      capacity: 1,
      coming: ["Loading"],
      date: DateTime(2099, 12, 31),
      hostname: "Loading",
      id: -999,
      location: "999999",
      title: "LOADING",
      owner: -999);
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await http
        .get(Uri.parse('${Api.CURR_URL}/meetups/${widget.id}'))
        .then((res) {
      Map<String, dynamic> a = jsonDecode(res.body);
      setState(() {
        print(a);
        md = Meetup(
          id: a['id'],
          title: a['title'],
          location: a['location'],
          capacity: a['capacity'],
          date: DateTime.parse(a['due']),
          coming: a['coming'],
          owner: a['owner'],
          hostname: a['hostname'],
        );
      });
    });
  }

  Widget build(BuildContext context) {
    int numComing = md.coming.length;
    int blkNum = int.parse(md.location.substring(3));
    String registered = numComing.toString() + "/" + md.capacity.toString();
    String attendeesName = "";

    for (int i = 0; i < numComing - 1; i++) {
      attendeesName += md.coming[i];
      attendeesName += ", ";
    }
    attendeesName += md.coming[numComing - 1];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Block
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/locations_meetup/${md.title.toLowerCase()}.jpeg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              child: Text(
                md.title,
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
            ),

            // Location Row
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    "Address: ",
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
            // Current Pax/Registered
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Text(
                    "Participant Count: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    registered,
                    style: TextStyle(
                      fontSize: 20,
                      color:
                          md.capacity == numComing ? Colors.red : Colors.black,
                    ),
                  )
                ],
              ),
            ),
            // Names of people attending Row
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Registered: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    attendeesName,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),

            numComing < md.capacity
                ? Padding(
                    padding: EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: () => selectMeetupHandler(
                          id: widget.id,
                          attendees: md.coming,
                          currentpax: numComing),
                      child: Text(
                        "Join Meetup",
                        style: TextStyle(fontSize: 30),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(250, 90),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text(
                            "Meetup FULL",
                            style: TextStyle(fontSize: 30),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(250, 90),
                          ),
                        ),
                      ),
                      Text(
                        "Go back and choose another meetup!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
