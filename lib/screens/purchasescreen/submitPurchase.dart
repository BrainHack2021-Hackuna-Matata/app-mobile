import 'dart:convert';

import 'package:eldertly_app/api/static.dart';
import 'package:eldertly_app/components/notifier.dart';
import 'package:http/http.dart' as http;

Future<http.Response> SubmitPurchase(
  UserNotifier user,
  String title,
  String description,
  String location,
  String due,
) {
  return http.post(
    Uri.parse('${Api.CURR_URL}api/posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "title": title,
      "description": description,
      "location": location,
      "items": [],
      "imageurl": "imageurl.com",
      "coming": [],
      "owner": user.currentUser.id,
      "due": due,
      "fulfilled": false,
      "accepted": false,
      "lat": user.currentUser.lat,
      "long": user.currentUser.long,
      "unit": user.currentUser.unit,
    }),
  );
}
