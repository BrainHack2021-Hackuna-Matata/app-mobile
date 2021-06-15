import 'package:flutter/material.dart';

<<<<<<< HEAD
class MeetupDetailsScreen extends StatelessWidget {
=======
class MeetupDetailsScreen extends StatefulWidget {
>>>>>>> master
  final String title;
  final String imageurl;
  final String location;
  final int capacity;
  final int currentpax;
  final List attendees;
<<<<<<< HEAD
=======
  final int id;
>>>>>>> master

  MeetupDetailsScreen({
    required this.title,
    required this.imageurl,
    required this.location,
    required this.capacity,
    required this.currentpax,
    required this.attendees,
<<<<<<< HEAD
  });

  void selectExerciseHandler() {
    //TODO pop dialogue screen to confirm and send it to
=======
    required this.id,
  });

  @override
  _MeetupDetailsScreenState createState() => _MeetupDetailsScreenState();
}

class _MeetupDetailsScreenState extends State<MeetupDetailsScreen> {
  void selectExerciseHandler({required int id, required int currentpax, required List attendees}) {
    //TODO pop dialogue screen to confirm and send it to
    //Call api to update participants and current pax
>>>>>>> master
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    int blkNum = int.parse(location.substring(3));

    String attendeesName = "";

    for (int i = 0; i < attendees.length - 1; i++) {
      attendeesName += attendees[i];
      attendeesName += ", ";
    }
    attendeesName += attendees[attendees.length - 1];
    return Scaffold(
      appBar: AppBar(
=======
    int blkNum = int.parse(widget.location.substring(3));
    String registered = widget.currentpax.toString() + "/" + widget.capacity.toString();

    String attendeesName = "";

    for (int i = 0; i < widget.attendees.length - 1; i++) {
      attendeesName += widget.attendees[i];
      attendeesName += ", ";
    }
    attendeesName += widget.attendees[widget.attendees.length - 1];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
>>>>>>> master
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
<<<<<<< HEAD
                  image: AssetImage(imageurl),
=======
                  image: AssetImage(widget.imageurl),
>>>>>>> master
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              child: Text(
<<<<<<< HEAD
                title,
=======
                widget.title,
>>>>>>> master
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
<<<<<<< HEAD

            // Attending Row
=======
            // Current Pax/Registered
>>>>>>> master
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Text(
<<<<<<< HEAD
                    "Participants: ",
=======
                    "Registered: ",
>>>>>>> master
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
<<<<<<< HEAD
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          attendeesName,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Capacity
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Text(
                    "Registered: ",
=======
                  Text(
                    registered,
                    style: TextStyle(
                      fontSize: 20,
                      color: widget.capacity == widget.currentpax ? Colors.red : Colors.black,
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
                    "Participants: ",
>>>>>>> master
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
<<<<<<< HEAD
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "$currentpax/",
                          style: TextStyle(
                            fontSize: 20,
                            color: capacity == currentpax
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                        Text(
                          "$capacity",
                          style: TextStyle(
                            fontSize: 20,
                            color: capacity == currentpax
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
=======
                  Text(
                    attendeesName,
                    style: TextStyle(fontSize: 20),
>>>>>>> master
                  ),
                ],
              ),
            ),
<<<<<<< HEAD
            currentpax < capacity
                ? Padding(
                    padding: EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: () => selectExerciseHandler(),
=======

            widget.currentpax < widget.capacity
                ? Padding(
                    padding: EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: () => selectExerciseHandler(id: widget.id, attendees: widget.attendees, currentpax: widget.currentpax),
>>>>>>> master
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
                      Text("Go back and choose another meetup!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ))
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
