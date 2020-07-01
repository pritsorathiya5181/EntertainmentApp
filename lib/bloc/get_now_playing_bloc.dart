import 'package:MovieApp/model/movie_response.dart';
import 'package:MovieApp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingListBloc {
  MovieRepository repository = MovieRepository();
  BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getPlayingMovies() async {
    MovieResponse response = await repository.getPlayingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final nowPlayingMoviesBloc = NowPlayingListBloc();
