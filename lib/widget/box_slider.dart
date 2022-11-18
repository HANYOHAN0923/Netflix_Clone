import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';

import '../screen/detail_screen.dart';

// circle_slider.dart와 같은 원리
class BoxSlider extends StatelessWidget {
  List<Movie> movies;
  BoxSlider({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("지금 뜨는 콘텐츠"),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeBoxImages(context,
                  movies), // List<Widget>을 리턴하는 함수로 children: <Widget>[]을 대체한다.
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeBoxImages(BuildContext context, List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movies[i]);
            }));
      },
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.network(movies[i].poster),
        ),
      ),
    ));
  }
  return results;
}
