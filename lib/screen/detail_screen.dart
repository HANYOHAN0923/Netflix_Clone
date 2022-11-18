import 'dart:ui'; // 이번 팝업 스크린을 위해 필요한
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/model/model_movie.dart';

// stful
class DetailScreen extends StatefulWidget {
  final Movie movie;
  DetailScreen({required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    like = widget.movie.like;
  }

  @override
  Widget build(BuildContext context) {
    // Detail Screen을 팝업 다이얼로그 형태로 만들기 위해서 Scaffold()
    return Scaffold(
      body: Container(
          child: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(widget.movie.poster),
                    fit: BoxFit.cover,
                  )),
                  child: ClipRRect(
                      child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.1),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                              child: Image.network(widget.movie.poster),
                              height: 300,
                            ),
                            Container(
                              padding: EdgeInsets.all(7),
                              child: Text(
                                "99% 일치 2023 15+ 시즌 1개",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7),
                              child: Text(
                                widget.movie.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(3),
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    Text("재생",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                            /*



                            이 부분 사진 바뀔 때마다 바뀌도록 수정해보자



                            */
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text("단발 여신 조유리, 우주 최강 여신 조유리, 대커율"),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "출연진: 조유리, 김채원, 최예나\n제작자: 한요한 (위즈원)",
                                style: TextStyle(
                                    color: Colors.white60, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ),
                Positioned(
                    // 이 위젯으로 상단 AppBar()를 만들 수 있다 (닫기 버튼은 팝업 다이얼로그에 기본적으로 적용된다. 따라서 따로 기능과 아이콘을 부가 설정 안 해도 됨)
                    child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ))
              ],
            ),
            Container(
              color: Colors.black26,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          like = !like;
                          widget.movie.reference!.update({'like': like});
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          like ? Icon(Icons.check) : Icon(Icons.add),
                          Padding(padding: EdgeInsets.all(5)),
                          Text("내가 찜한 컨텐츠",
                              style: TextStyle(
                                  fontSize: 11, color: Colors.white60))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.thumb_up),
                          Padding(padding: EdgeInsets.all(5)),
                          Text(
                            "평가",
                            style:
                                TextStyle(fontSize: 11, color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.send),
                          Padding(padding: EdgeInsets.all(5)),
                          Text(
                            "공유",
                            style:
                                TextStyle(fontSize: 11, color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
