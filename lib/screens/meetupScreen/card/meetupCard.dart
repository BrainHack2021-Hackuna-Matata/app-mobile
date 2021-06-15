import 'package:flutter/material.dart';

class MeetupCard extends StatelessWidget {
  final int id;
  final String title;
  final String imageurl;
  final String location;
  final int capacity;
  final int currentpax;
  MeetupCard({
    required this.id,
    required this.title,
    required this.imageurl,
    required this.location,
    required this.capacity,
    required this.currentpax,
  });

  void tapCard(BuildContext context) {
    //TODO : Push to meetup detail screen
  }

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
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image(
                    image: AssetImage(imageurl),
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
                        Icons.person,
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
          ],
        ),
      ),
    );
  }
}
