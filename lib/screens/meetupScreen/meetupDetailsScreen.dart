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
  List meetupDetails = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await http
        .get(Uri.parse('${Api.CURR_URL}/meetups/${widget.id}'))
        .then((res) {
      List array = jsonDecode(res.body);
      var formattedArray = array.map((a) {
        return Meetup(
          id: a['id'],
          title: a['title'],
          description: a['description'],
          location: a['location'],
          capacity: a['capacity'],
          imageurl: a['imageurl'],
          date: DateTime.parse(a['due']),
          coming: a['coming'],
          owner: a['owner'],
          hostname: a['hostname'],
        );
      }).toList();
      setState(() {
        meetupDetails = formattedArray;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(body: Text("Test"));
    print(meetupDetails);
    //   int blkNum = int.parse(widget.location.substring(3));
    //   String registered =
    //       widget.currentpax.toString() + "/" + widget.capacity.toString();

    //   String attendeesName = "";

    //   for (int i = 0; i < widget.attendees.length - 1; i++) {
    //     attendeesName += widget.attendees[i];
    //     attendeesName += ", ";
    //   }
    //   attendeesName += widget.attendees[widget.attendees.length - 1];
    //   return Scaffold(
    //     appBar: AppBar(
    //       centerTitle: true,
    //       title: Text("Details"),
    //     ),
    //     body: Center(
    //       child: Column(
    //         children: <Widget>[
    //           // Block
    //           Container(
    //             width: MediaQuery.of(context).size.width,
    //             height: 200,
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                 image: AssetImage(widget.imageurl),
    //                 fit: BoxFit.fitWidth,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             child: Text(
    //               widget.title,
    //               style: TextStyle(
    //                 fontSize: 36,
    //               ),
    //             ),
    //             alignment: Alignment.topLeft,
    //             padding: EdgeInsets.all(10),
    //           ),

    //           // Location Row
    //           Container(
    //             child: Row(
    //               children: <Widget>[
    //                 Text(
    //                   "Address: ",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Text(
    //                   "BLK $blkNum",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    //           ),
    //           // Current Pax/Registered
    //           Container(
    //             padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    //             child: Row(
    //               children: <Widget>[
    //                 Text(
    //                   "Participant Count: ",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Text(
    //                   registered,
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     color: widget.capacity == widget.currentpax
    //                         ? Colors.red
    //                         : Colors.black,
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           // Names of people attending Row
    //           Container(
    //             padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    //             width: MediaQuery.of(context).size.width,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   "Registered: ",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Text(
    //                   attendeesName,
    //                   style: TextStyle(fontSize: 20),
    //                 ),
    //               ],
    //             ),
    //           ),

    //           widget.currentpax < widget.capacity
    //               ? Padding(
    //                   padding: EdgeInsets.all(25),
    //                   child: ElevatedButton(
    //                     onPressed: () => selectMeetupHandler(
    //                         id: widget.id,
    //                         attendees: widget.attendees,
    //                         currentpax: widget.currentpax),
    //                     child: Text(
    //                       "Join Meetup",
    //                       style: TextStyle(fontSize: 30),
    //                     ),
    //                     style: ElevatedButton.styleFrom(
    //                       minimumSize: Size(250, 90),
    //                     ),
    //                   ),
    //                 )
    //               : Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Padding(
    //                       padding: EdgeInsets.all(25),
    //                       child: ElevatedButton(
    //                         onPressed: null,
    //                         child: Text(
    //                           "Meetup FULL",
    //                           style: TextStyle(fontSize: 30),
    //                         ),
    //                         style: ElevatedButton.styleFrom(
    //                           minimumSize: Size(250, 90),
    //                         ),
    //                       ),
    //                     ),
    //                     Text("Go back and choose another meetup!",
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(
    //                           fontSize: 28,
    //                           fontWeight: FontWeight.bold,
    //                           color: Colors.red,
    //                         ))
    //                   ],
    //                 )
    //         ],
    //       ),
    //     ),
    //   );
  }
}
