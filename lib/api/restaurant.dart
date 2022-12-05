class Restaurant {
  int id;
  String title;
  String poster;


  Restaurant(
      {required this.id,
        required this.title,
        required this.poster,});

  factory Restaurant.fromJson(Map json) {
    return Restaurant(
        id: json["id"],
        title: json["title"],
        poster: json["poster"]);

  }
}
