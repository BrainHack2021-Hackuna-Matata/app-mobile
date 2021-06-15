class Meetup {
  final int id;
  final String title;
  final String description;
  final String location;
  final int capacity;
  final String imageurl;
  final List<String> coming;
  final int owner;
  const Meetup({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.capacity,
    required this.imageurl,
    required this.coming,
    required this.owner,
  });
}
