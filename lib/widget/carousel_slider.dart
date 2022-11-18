import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/screen/detail_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({required this.movies});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;

  int _currentPage = 0;
  late String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((e) => Image.network(e.poster)).toList();
    keywords = movies.map((e) => e.keyword).toList();
    likes = movies.map((e) => e.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(padding: EdgeInsets.all(20)),
          CarouselSlider(
              items: images,
              options: CarouselOptions(onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                  _currentKeyword = keywords[_currentPage];
                });
              })),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    // "찜하기" 선택 여부에 따라 찜하기, 이미 찜한 체크 버튼 두개 아이콘 렌더링 선택
                    likes[_currentPage]
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                likes[_currentPage] = !likes[_currentPage];
                                movies[_currentPage]
                                    .reference!
                                    .update({'like': likes[_currentPage]});
                              });
                            },
                            icon: Icon(Icons.check))
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                likes[_currentPage] = !likes[_currentPage];
                                movies[_currentPage]
                                    .reference!
                                    .update({'like': likes[_currentPage]});
                              });
                            },
                            icon: Icon(Icons.add)),
                    Text(
                      '내가 찜한 컨텐츠',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                )),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text("재생", style: TextStyle(color: Colors.black))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            fullscreenDialog: true,
                            builder: (BuildContext context) {
                              return DetailScreen(movie: movies[_currentPage]);
                            }));
                      },
                    ),
                    Text(
                      "정보",
                      style: TextStyle(fontSize: 11),
                    )
                  ]),
                )
              ],
            ),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: makeIndicator(likes, _currentPage),
          ))
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    ));
  }

  return result;
}
