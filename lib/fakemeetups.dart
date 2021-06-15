import './models/meetup.dart';

//Can dleete this once setup si don

const FAKE_MEETUPS = const [
  Meetup(
    id: 1,
    title: 'Chess',
    description: 'unused',
    location: '654423',
    capacity: 2,
    imageurl: 'assets/locations_meetup/chess.jpeg',
    coming: [
      'Bob',
      'Ali',
    ],
    owner: 1,
  ),
  Meetup(
    id: 2,
    title: 'Cards',
    description: 'unused',
    location: '654321',
    capacity: 4,
    imageurl: 'assets/locations_meetup/cards.JPG',
    coming: [
      'Bob',
    ],
    owner: 1,
  ),
  Meetup(
    id: 3,
    title: 'Mahjong',
    description: 'unused',
    location: '654001',
    capacity: 4,
    imageurl: 'assets/locations_meetup/mahjong.jpeg',
    coming: [
      'Bob',
      'Ali',
      'Cock',
    ],
    owner: 1,
  ),
  Meetup(
    id: 4,
    title: 'Mahjong',
    description: 'unused',
    location: '654021',
    capacity: 4,
    imageurl: 'assets/locations_meetup/mahjong.jpeg',
    coming: [
      'Bob',
      'Ali',
      'Cock',
    ],
    owner: 1,
  ),
];
