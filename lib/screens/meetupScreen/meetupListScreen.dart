import 'package:flutter/material.dart';

import 'card/meetupCard.dart';
import 'addMeetupScreen.dart';
import '../../fakemeetups.dart';

class MeetupListScreen extends StatefulWidget {
  const MeetupListScreen({Key? key}) : super(key: key);

  @override
  _MeetupListScreenState createState() => _MeetupListScreenState();
}

class _MeetupListScreenState extends State<MeetupListScreen> {
  final meetups = FAKE_MEETUPS;
  void handleRefresh() {
    setState(() {});
  }

  void handleAdd() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddMeetupScreen()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meetups"),
      ),
      body: ListView.builder(
        //Returns a card for each item in the meetups list (currently tagged to fakemeetups)
        padding: const EdgeInsets.only(bottom: 200),
        itemBuilder: (ctx, index) {
          return MeetupCard(
            id: meetups[index].id,
            title: meetups[index].title,
            imageurl: meetups[index].imageurl,
            location: meetups[index].location,
            capacity: meetups[index].capacity,
            currentpax: meetups[index].coming.length,
            attendees: meetups[index].coming,
          );
        },
        itemCount: meetups.length,
      ),
      //Adding two FloatingActionButtons into meetuplistscreen
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 100,
                width: 100,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: handleRefresh,
                  child: Icon(
                    Icons.refresh,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 100,
              width: 100,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: handleAdd,
                child: Icon(
                  Icons.add,
                  size: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
