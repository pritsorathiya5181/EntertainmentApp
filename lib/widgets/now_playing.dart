import 'package:MovieApp/bloc/get_now_playing_bloc.dart';
import 'package:MovieApp/model/movie.dart';
import 'package:MovieApp/model/movie_response.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:MovieApp/style/theme.dart' as Style;

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc.getPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshots) {
        if (snapshots.hasData) {
          if (snapshots.data.error != null && snapshots.data.error.length > 0) {
            return _buildErrorWidget(snapshots.data.error);
          }
          return _buildNowPlayingWiget(snapshots.data);
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

  Widget _buildNowPlayingWiget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("No Movie"),
          ],
        ),
      );
    } else {
      return Container(
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          length: movies.take(5).length,
          padding: EdgeInsets.all(5.0),
          indicatorColor: Style.Colors.titleColor,
          shape: IndicatorShape.circle(size: 8.0),
          indicatorSelectorColor: Style.Colors.secondColor,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(5).length,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://image.tmdb.org/t/p/original/" +
                                movies[index].backPoster),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Style.Colors.mainColor.withOpacity(1.0),
                            Style.Colors.mainColor.withOpacity(0.0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.0, 0.9]),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    top: 0,
                    right: 0,
                    child: Icon(
                      FontAwesomeIcons.playCircle,
                      size: 40.0,
                      color: Style.Colors.secondColor.withOpacity(0.9),
                      
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            movies[index].title,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    }
  }
}
