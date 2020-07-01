import 'package:MovieApp/model/movie_response.dart';
import 'package:MovieApp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  MovieRepository repository = MovieRepository();
  BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await repository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesBloc = MoviesListBloc();
