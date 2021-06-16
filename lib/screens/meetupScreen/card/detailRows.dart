import 'package:flutter/material.dart';

class DetailRows extends StatelessWidget {
  final String field;
  final String body;
  final Color fieldColor;

  DetailRows(this.field, this.body, [this.fieldColor = Colors.black]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: <Widget>[
          Text(
            field,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            body,
            style: TextStyle(
              color: fieldColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
