class Movie {
  final int id;
  final double popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final double ratings;

  Movie({this.id, this.popularity, this.title, this.backPoster, this.poster,
      this.overview, this.ratings});

  Movie.fromJson(Map<String, dynamic> json)
  : id = json["id"],
    popularity = json["popularity"].toDouble(),
    title = json["title"],
    backPoster = json["backdrop_path"],
    poster = json["poster_path"],
    overview = json["overview"],
    ratings = json["vote_average"].toDouble();
}
