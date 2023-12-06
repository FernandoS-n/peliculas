import 'dart:convert';

class Cast {
  List<Actor> actores = [];
  Cast.fromJsonList(List<dynamic> jsonList) {
    for (var element in jsonList) {
      final actor = Actor.fromJson(element);
      actores.add(actor);
    }
  }
}

class Actor {
  bool adult = false;
  int gender = 0;
  int id = 0;
  // String knownForDepartment;
  String name = '';
  String originalName = '';
  double popularity = 0.0;
  String profilePath = '';
  int castId = 0;
  String character = '';
  String creditId = '';
  int order = 0;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    // required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Actor.fromRawJson(String str) => Actor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Actor.fromJson(Map<String, dynamic> json) {
    String fotoPersonaje = '';
    if (json['profile_path'] != null) fotoPersonaje = json['profile_path'];

    adult = json["adult"];
    gender = json["gender"];
    id = json["id"];
    // knownForDepartment = json["known_for_department"];
    name = json["name"];
    originalName = json["original_name"];
    popularity = json["popularity"]?.toDouble();
    profilePath = fotoPersonaje;
    castId = json["cast_id"];
    character = json["character"];
    creditId = json["credit_id"];
    order = json["order"];
  }

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        // "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
      };

  getFoto() {
    if (profilePath == '') {
      return 'https://res.cloudinary.com/dtg3eecnd/image/upload/v1674269635/ohg6sduddis32aj7epu3.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
