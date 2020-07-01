import 'package:MovieApp/model/genre_response.dart';
import 'package:MovieApp/model/movie_response.dart';
import 'package:MovieApp/model/person_response.dart';
import 'package:dio/dio.dart';

class MovieRepository {
  final String apiKey = "4aa910a4171ca22844c94ae36e991131";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMovieUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';
  var getPersonUrl = '$mainUrl/trending/person/week';
  var movieUrl = '$mainUrl/movie';

  Future<MovieResponse> getMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (err, stacktrace) {
      print("Error Occured: $err stackTrace: $stacktrace");
      return MovieResponse.withError("$err");
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (err, stacktrace) {
      print("Error Occured: $err stackTrace: $stacktrace");
      return MovieResponse.withError("$err");
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (err, stacktrace) {
      print("Error Occured: $err stackTrace: $stacktrace");
      return GenreResponse.withError("$err");
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {"api_key": apiKey};

    try {
      Response response = await dio.get(getPersonUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (err, stacktrace) {
      print("Error Occured: $err stackTrace: $stacktrace");
      return PersonResponse.withError("$err");
    }
  }

  Future<MovieResponse> getMoviesbyGenre(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
      "with_genres": id
    };

    try {
      Response response = await dio.get(getMovieUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (err, stacktrace) {
      print("Error Occured: $err stackTrace: $stacktrace");
      return MovieResponse.withError("$err");
    }
  }
}
