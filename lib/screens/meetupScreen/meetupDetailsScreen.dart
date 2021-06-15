import 'package:flutter/material.dart';

class MeetupDetailsScreen extends StatelessWidget {
  final String title;
  final String imageurl;
  final String location;
  final int capacity;
  final int currentpax;
  final List attendees;

  MeetupDetailsScreen({
    required this.title,
    required this.imageurl,
    required this.location,
    required this.capacity,
    required this.currentpax,
    required this.attendees,
  });

  void selectExerciseHandler() {
    //TODO pop dialogue screen to confirm and send it to
  }

  @override
  Widget build(BuildContext context) {
    int blkNum = int.parse(location.substring(3));

    String attendeesName = "";

    for (int i = 0; i < attendees.length - 1; i++) {
      attendeesName += attendees[i];
      attendeesName += ", ";
    }
    attendeesName += attendees[attendees.length - 1];
    return Scaffold(
      appBar: AppBar(
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
                  image: AssetImage(imageurl),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              child: Text(
                title,
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

            // Attending Row
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Text(
                    "Participants: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  ),
                ],
              ),
            ),
            currentpax < capacity
                ? Padding(
                    padding: EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: () => selectExerciseHandler(),
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
