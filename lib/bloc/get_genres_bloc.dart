import 'package:MovieApp/model/genre_response.dart';
import 'package:MovieApp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GenresListBloc {
  MovieRepository repository = MovieRepository();
  BehaviorSubject<GenreResponse> _subject = BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await repository.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

final genresBloc = GenresListBloc();
