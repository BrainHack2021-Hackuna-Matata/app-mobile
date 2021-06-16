class Meetup {
  final int id;
  final String title;
  final String description;
  final String location;
  final int capacity;
  final String imageurl;
  final DateTime date;
  final List<dynamic> coming;
  final int owner;
  final String hostname;
  const Meetup(
      {required this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.capacity,
      required this.imageurl,
      required this.date,
      required this.coming,
      required this.owner,
      required this.hostname});
}
