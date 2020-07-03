import 'package:MovieApp/bloc/get_genres_bloc.dart';
import 'package:MovieApp/model/genre.dart';
import 'package:MovieApp/model/genre_response.dart';
import 'package:MovieApp/widgets/genres_list.dart';
import 'package:flutter/material.dart';

class GenresScreen extends StatefulWidget {
  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  void initState() {
    super.initState();
    genresBloc.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
      stream: genresBloc.subject.stream,
      builder: (context, AsyncSnapshot<GenreResponse> snapshots) {
        if (snapshots.hasData) {
          if (snapshots.data.error != null && snapshots.data.error.length > 0) {
            return _buildErrorWidget(snapshots.data.error);
          }
          return _buildGenresWidget(snapshots.data);
        } else if (snapshots.hasError) {
          return _buildErrorWidget(snapshots.error);
        } else {
          return _buildLoadingWidget();
        }
      },
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

  Widget _buildGenresWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    if (genres.length == 0) {
      return Container(
        child: Text('No Genres'),
      );
    } else
      return GenresList(
        genres: genres,
      );
  }
}
