import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../components/notifier.dart';
import '../../api/static.dart';
import '../../models/meetup.dart';
import './card/detailRows.dart';
import './buttons/registered.dart';
import './buttons/newRegister.dart';

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

  String userName = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    userName = Provider.of<UserNotifier>(context).currentUser.name;
    super.didChangeDependencies();
  }

  void getData() async {
    await http
        .get(Uri.parse('${Api.CURR_URL}/meetups/${widget.id}'))
        .then((res) {
      Map<String, dynamic> a = jsonDecode(res.body);
      setState(() {
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
    String numRegistered = numComing.toString() + "/" + md.capacity.toString();
    String attendeesName = "";
    String eventDate = DateFormat('dd MMM').format(md.date);
    String hostName = md.hostname;

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
            // Image
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
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

            // Current Pax/Registered
            DetailRows(
              "Participant Count: ",
              numRegistered,
              md.capacity == numComing ? Colors.red : Colors.black,
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

            // Location Row
            DetailRows(
              "Address: ",
              "BLK $blkNum",
            ),

            DetailRows(
              "Date of Event: ",
              eventDate,
            ),

            DetailRows(
              "Name of Host: ",
              hostName.length > 15
                  ? hostName.replaceRange(14, hostName.length, '...')
                  : hostName,
            ),

            md.coming.contains(userName)
                ? Registered(
                    userName: userName,
                    numComing: numComing,
                    attendees: md.coming,
                  )
                : NewRegister(
                    userName: userName,
                    numComing: numComing,
                    capacity: md.capacity,
                    attendees: md.coming,
                  ),
          ],
        ),
      ),
    );
  }
}
