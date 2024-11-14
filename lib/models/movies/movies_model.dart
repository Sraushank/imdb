
import 'dart:convert';

List<Movies> moviesFromJson(String str) => List<Movies>.from(json.decode(str).map((x) => Movies.fromJson(x)));

String moviesToJson(List<Movies> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movies {
  int? rank;
  String? title;
  String? description;
  String? image;
  String? bigImage;
  List<String>? genre;
  String? thumbnail;
  double? rating;
  String? id;
  String? year;
  String? imdbid;
  String? imdbLink;

  Movies({
    this.rank,
    this.title,
    this.description,
    this.image,
    this.bigImage,
    this.genre,
    this.thumbnail,
    this.rating,
    this.id,
    this.year,
    this.imdbid,
    this.imdbLink,
  });

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
    rank: json["rank"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    bigImage: json["big_image"],
    genre: json["genre"] == null ? [] : List<String>.from(json["genre"]!.map((x) => x)),
    thumbnail: json["thumbnail"],
    rating: json["rating"]?.toDouble(),
    id: json["id"],
    year: json["year"],
    imdbid: json["imdbid"],
    imdbLink: json["imdb_link"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "title": title,
    "description": description,
    "image": image,
    "big_image": bigImage,
    "genre": genre == null ? [] : List<dynamic>.from(genre!.map((x) => x)),
    "thumbnail": thumbnail,
    "rating": rating,
    "id": id,
    "year": year,
    "imdbid": imdbid,
    "imdb_link": imdbLink,
  };
}
