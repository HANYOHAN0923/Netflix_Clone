import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';

import '../screen/detail_screen.dart';

// CircleSlider Widget은 state 변화가 없어서 stless
class CircleSlider extends StatelessWidget {
  final List<Movie> movies;
  CircleSlider({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("미리보기"),
          Container(
            height: 120,
            child: ListView(
              // 수직 혹은 수평으로 스크롤이 가능한 뷰어 위젯을 만든다
              scrollDirection: Axis.horizontal,
              children: makeCircleImages(context,
                  movies), // List<Widget>을 리턴하는 함수로 children: <Widget>[]을 대체한다. (사실 같은 뜻이긴 해)
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(BuildContext context, List<Movie> movies) {
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
          child: CircleAvatar(
            backgroundImage: NetworkImage(movies[i].poster),
            radius: 48,
          ),
        ),
      ),
    ));
  }
  return results;
}
