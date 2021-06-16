class Post {
  final int id;
  final String title;
  final String description;
  final String location; //blknumber
  final List items;
  final String imageurl;
  final List<dynamic> coming;
  final int owner;
  final DateTime created;
  final DateTime due;
  final bool fulfilled;
  final bool accepted;
  final double lat;
  final double long;
  final String unit;
  const Post(
      {  required this.id,
          required this.title,
          required this.description,
          required this.location,
          required this.items,
          required this.imageurl,
          required this.coming,
          required this.owner,
          required this.created,
          required this.due,
          required this.fulfilled,
          required this.accepted,
          required this.lat,
          required this.long,
          required this.unit,
          });
}
