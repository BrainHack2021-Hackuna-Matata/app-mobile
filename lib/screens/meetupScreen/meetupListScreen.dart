import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api/static.dart';
import '../../models/meetup.dart';
import 'card/meetupCard.dart';
import 'meetupCreatorScreen.dart';

class MeetupListScreen extends StatefulWidget {
  const MeetupListScreen({Key? key}) : super(key: key);

  @override
  _MeetupListScreenState createState() => _MeetupListScreenState();
}

class _MeetupListScreenState extends State<MeetupListScreen> {
  List<dynamic> meetups = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await http.get(Uri.parse('${Api.CURR_URL}/meetups')).then((res) {
      List array = jsonDecode(res.body);
      var formattedArray = array.map((a) {
        return Meetup(
          id: a['id'],
          title: a['title'],
          location: a['location'],
          capacity: a['capacity'],
          date: DateTime.parse(a['due']),
          coming: a['coming'],
          owner: a['owner'],
          hostname: a['hostname'],
        );
      }).toList();
      setState(() {
        meetups = formattedArray;
      });
    });
  }

  void handleRefresh() async {
    getData();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Updated Meetups!")));
  }

  void handleAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMeetupScreen(),
      ),
    ).then((res) {
      handleRefresh();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: Consumer<UserNotifier>(
      //         builder: (context, user, child) =>
      //             Text(user.currentUser.mobile))),
      appBar: AppBar(
        title: Text("Meetups"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),

      body: meetups.length != 0
          ? ListView.builder(
              //Returns a card for each item in the meetups list (currently tagged to fakemeetups)
              padding: const EdgeInsets.only(bottom: 200),
              itemBuilder: (ctx, index) {
                return MeetupCard(
                  id: meetups[index].id,
                  title: meetups[index].title,
                  location: meetups[index].location,
                  capacity: meetups[index].capacity,
                  currentpax: meetups[index].coming.length,
                  attendees: meetups[index].coming,
                  date: meetups[index].date,
                  hostname: meetups[index].hostname,
                  getData: handleRefresh,
                );
              },
              itemCount: meetups.length,
            )
          : Center(
              child: Text(
                "Loading meetups, please wait!",
                style: TextStyle(fontSize: 20),
              ),
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
