import './models/meetup.dart';

//Can dleete this once setup si don

DateTime randomdate = DateTime.fromMillisecondsSinceEpoch(1623803158);

var FAKE_MEETUPS = [
  Meetup(
    id: 1,
    title: 'Chess',
    description: 'unused',
    location: '654423',
    capacity: 2,
    imageurl: 'assets/locations_meetup/chess.jpeg',
    date: randomdate,
    coming: [
      'Bob',
      'Ali',
    ],
    owner: 1,
    hostname: "Bob",
  ),
  Meetup(
    id: 2,
    title: 'Cards',
    description: 'unused',
    location: '654321',
    capacity: 4,
    imageurl: 'assets/locations_meetup/cards.JPG',
    date: randomdate,
    coming: [
      'Bob',
    ],
    owner: 1,
    hostname: "Bob",
  ),
  Meetup(
    id: 3,
    title: 'Mahjong',
    description: 'unused',
    location: '654001',
    capacity: 4,
    imageurl: 'assets/locations_meetup/mahjong.jpeg',
    date: randomdate,
    coming: [
      'Bob',
      'Ali',
      'Cock',
    ],
    owner: 1,
    hostname: "Bob",
  ),
  Meetup(
    id: 4,
    title: 'Mahjong',
    description: 'unused',
    location: '654021',
    capacity: 4,
    imageurl: 'assets/locations_meetup/mahjong.jpeg',
    date: randomdate,
    coming: [
      'Bobob Bob Bob Bob',
      'Ali Ali Ali Ali Ali Ali Ali',
      'Cock Cock CoCk COck COck Cok',
    ],
    owner: 1,
    hostname: "Bob",
  ),
];
