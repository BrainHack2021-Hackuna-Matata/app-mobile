import 'package:eldertly_app/components/notifier.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String myJsonParser(
    {required String title,
    required String description,
    required String location,
    required int owner,
    required String due,
    required double lat,
    required double long,
    required String unit,
}) {
  return jsonEncode({
    "title": title,
    "description": description,
    "location": location,
    "items": [],
    "imageurl": "imageurl.com",
    "coming": [],
    "owner": owner,
    "due": due,
    "fulfilled": false,
    "accepted": false,
    "lat": lat,
    "long": long,
    "unit": unit,
  });
}

Future<http.Response> SubmitPurchase(
  UserNotifier user,
  String title,
  String description,
  String location,
  String due,
) {
  print("submit");
  return http.post(Uri.parse('https://hackuna-matata.herokuapp.com/api/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: myJsonParser(
        title: title,
        description: description,
        location: location,
        owner: int.parse(user.currentUser.mobile),
        due: due,
        lat: user.currentUser.lat,
        long: user.currentUser.long,
        unit: user.currentUser.unit,
      ));
}

class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
