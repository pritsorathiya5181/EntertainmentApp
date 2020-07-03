import 'package:MovieApp/bloc/get_persons_bloc.dart';
import 'package:MovieApp/model/person.dart';
import 'package:MovieApp/model/person_response.dart';
import 'package:flutter/material.dart';
import 'package:MovieApp/style/theme.dart' as Style;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonList extends StatefulWidget {
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  void initState() {
    super.initState();
    personsBloc..getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            'Trending Person This Week',
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<PersonResponse>(
          stream: personsBloc.subject.stream,
          builder: (context, AsyncSnapshot<PersonResponse> snapshots) {
            if (snapshots.hasData) {
              if (snapshots.data.error != null &&
                  snapshots.data.error.length > 0) {
                return _buildErrorWidget(snapshots.data.error);
              }
              return _buildPersonsWidget(snapshots.data);
            } else if (snapshots.hasError) {
              return _buildErrorWidget(snapshots.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Error Ocuured $error",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonsWidget(PersonResponse data) {
    List<Person> persons = data.persons;
    if (persons.length == 0) {
      return Container(
        child: Column(
          children: <Widget>[Text('No Person trending')],
        ),
      );
    } else {
      return Container(
        height: 116,
        child: ListView.builder(
            itemCount: persons.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      persons[index].profileImg == null
                          ? Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Style.Colors.secondColor,
                              ),
                              child: Icon(FontAwesomeIcons.userAlt,
                                  color: Colors.white),
                            )
                          : Column(
                              children: <Widget>[
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w200' +
                                                persons[index].profileImg),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  persons[index].name,
                                  maxLines: 2,
                                  style: TextStyle(
                                    height: 1.4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Trending for ${persons[index].known}",
                                  style: TextStyle(
                                      color: Style.Colors.titleColor,
                                      fontSize: 7.0,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
