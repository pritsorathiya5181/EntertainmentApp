import 'package:MovieApp/model/person_response.dart';
import 'package:MovieApp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonsListBloc {
  MovieRepository repository = MovieRepository();
  BehaviorSubject<PersonResponse> _subject = BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await repository.getPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personsBloc = PersonsListBloc();
