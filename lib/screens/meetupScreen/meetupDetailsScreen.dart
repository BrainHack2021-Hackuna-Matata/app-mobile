import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './buttons/newRegister.dart';
import './buttons/registered.dart';
import './card/detailRows.dart';
import '../../api/static.dart';
import '../../components/notifier.dart';
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
  //meetup details
  Meetup md = Meetup(capacity: 1, coming: ["Loading"], date: DateTime(2099, 12, 31), hostname: "Loading", id: -999, location: "999999", title: "LOADING", owner: -999);

  String userName = "";

  int userID = -999;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    userName = Provider.of<UserNotifier>(context).currentUser.name;
    userID = Provider.of<UserNotifier>(context).currentUser.id;
    super.didChangeDependencies();
  }

  void registerMeetupHandler(BuildContext context) async {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Confirm Register?',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                content: const Text(
                  'Are you sure you want to register for this event?',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      var newuser = [...md.coming, userName];
                      await http
                          .post(
                        Uri.parse('${Api.CURR_URL}/meetups/${widget.id}'),
                        body: jsonEncode(
                          {
                            'coming': newuser,
                          },
                        ),
                      )
                          .then((res) {
                        print(res.body);
                      });
                      getData();
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ]));
  }

  void deregisterMeetupHandler(BuildContext context) async {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Confirm Unregister?',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                content: const Text(
                  'Are you sure you want to unregister for this event?',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      var newuser = [...md.coming].where((i) => i != userName).toList();
                      await http
                          .post(
                        Uri.parse('${Api.CURR_URL}/meetups/${widget.id}'),
                        body: jsonEncode(
                          {
                            'coming': newuser,
                          },
                        ),
                      )
                          .then((res) {
                        print(res.body);
                      });
                      getData();
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ]));
  }

  void deleteMeetupHandler(BuildContext context) async {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Confirm Delete?',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                content: const Text(
                  'Are you sure you want to delete this event?',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName('/tabscreen'),
                      );
                      await http
                          .delete(
                        Uri.parse('${Api.CURR_URL}/meetups/${widget.id}'),
                      )
                          .then((res) {
                        print(res.body);
                      });
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ]));
  }

  void getData() async {
    await http.get(Uri.parse('${Api.CURR_URL}/meetups/${widget.id}')).then((res) {
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

  @override
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
        child: md.coming[0] == 'Loading'
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  // Image
                  Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/locations_meetup/${md.title.toLowerCase()}.jpeg"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 10,
                        child: md.hostname == userName
                            ? Container(
                                width: 250,
                                color: Colors.blue,
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'My Meetup!',
                                  style: TextStyle(
                                    fontSize: 36,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              )
                            : md.coming.contains(userName)
                                ? Container(
                                    width: 250,
                                    color: Colors.green,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      'Attending!',
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: Colors.white,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ),
                                  )
                                : Container(),
                      )
                    ],
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
                    hostName.length > 15 ? hostName.replaceRange(14, hostName.length, '...') : hostName,
                  ),

                  md.coming.contains(userName)
                      ? Registered(
                          id: widget.id,
                          userID: userID,
                          userName: userName,
                          numComing: numComing,
                          owner: md.owner,
                          attendees: md.coming,
                          deregisterMeetupHandler: deregisterMeetupHandler,
                          deleteMeetupHandler: deleteMeetupHandler,
                          hostname: hostName,
                        )
                      : NewRegister(
                          id: widget.id,
                          userName: userName,
                          numComing: numComing,
                          capacity: md.capacity,
                          attendees: md.coming,
                          registerMeetupHandler: registerMeetupHandler,
                        ),
                ],
              ),
      ),
    );
  }
}
