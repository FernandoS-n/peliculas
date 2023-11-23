class ListaPeliculas {
  List<Pelicula> items = [];

  ListaPeliculas();

  ListaPeliculas.fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final pelicula = Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String uniqueId = '';
  bool adult = false;
  String backdropPath = '';
  List<int> genreIds = [];
  int id = 0;
  String originalLanguage = '';
  String originalTitle = '';
  String overview = '';
  double popularity = 0.0;
  String posterPath = '';
  String releaseDate = '';
  String title = '';
  bool video = false;
  double voteAverage = 0.0;
  int voteCount = 0;

  Pelicula({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json["backdrop_path"];
    genreIds = json["genre_ids"].cast<int>();
    id = json["id"];
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"] / 1;
    posterPath = json["poster_path"];
    releaseDate = json["release_date"];
    title = json["title"];
    video = json["video"];
    voteAverage = json["vote_average"] / 1;
    voteCount = json["vote_count"];
  }

  getPosterimg() {
    if (posterPath == '') {
      return 'https://res.cloudinary.com/dtg3eecnd/image/upload/v1674269635/ohg6sduddis32aj7epu3.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackground() {
    if (posterPath == '') {
      return 'https://res.cloudinary.com/dtg3eecnd/image/upload/v1674269635/ohg6sduddis32aj7epu3.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
