import 'package:MovieApp/model/movie_response.dart';
import 'package:MovieApp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListByGenreBloc {
  MovieRepository repository = MovieRepository();
  BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMoviesByGenre(int id) async {
    MovieResponse response = await repository.getMoviesbyGenre(id);
    _subject.sink.add(response);
  }

  void drainStream() { _subject.value = null; }
  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesBygenreBloc = MoviesListByGenreBloc();
