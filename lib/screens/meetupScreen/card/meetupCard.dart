import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/notifier.dart';
import './../meetupDetailsScreen.dart';

class MeetupCard extends StatelessWidget {
  final int id;
  final String title;
  final String location;
  final int capacity;
  final int currentpax;
  final List attendees;
  final DateTime date;
  final String hostname;
  final Function getData;
  MeetupCard({
    required this.id,
    required this.title,
    required this.location,
    required this.capacity,
    required this.currentpax,
    required this.attendees,
    required this.date,
    required this.hostname,
    required this.getData,
  });

  void tapCard(BuildContext context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => MeetupDetailsScreen(
          id: id,
        ),
      ),
    )
        .then((res) async {
      getData();
    });
  }

  final DateFormat formatter = DateFormat('dd MMM');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => tapCard(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Consumer<UserNotifier>(
          builder: (context, user, child) => Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image(
                      image: AssetImage(
                          "assets/locations_meetup/${title.toLowerCase()}.jpeg"),
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 250,
                      color: Colors.black54,
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 10,
                    child: user.currentUser.name == hostname
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
                        : attendees.contains(user.currentUser.name)
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
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.people,
                          size: 26,
                          color: currentpax == capacity ? Colors.red : null,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '$currentpax/$capacity',
                          style: TextStyle(
                            fontSize: 26,
                            color: currentpax == capacity ? Colors.red : null,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.map,
                          size: 26,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '$location',
                          style: TextStyle(
                            fontSize: 26,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          size: 26,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '${formatter.format(date)}',
                          style: TextStyle(
                            fontSize: 26,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 26,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          hostname.length > 8
                              ? hostname.replaceRange(7, hostname.length, '...')
                              : hostname,
                          style: TextStyle(
                            fontSize: 26,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
