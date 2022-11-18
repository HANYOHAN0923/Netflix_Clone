import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/widget/box_slider.dart';
import 'package:netflix_clone/widget/carousel_slider.dart';
import 'package:netflix_clone/widget/circle_slider.dart';

// 데이터를 백엔드에서 가져와야하기 때문에
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? streamData;

  @override
  void initState() {
    super.initState();
    // 스트림데이터
    streamData = firestore.collection('movie').snapshots();
  }

  // streamData에서 Data 추출 후 위젯으로 변환
  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator(); // 데이터 못 가져왔을 때 로딩 화면
        return _buildBody(context, snapshot.data!.docs);
      }),
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    // snapshot의 데이터를 Movie 모델의 형태로 전환하고, 데이터들을 리스트 형태로 만들기
    List<Movie> movies = snapshot.map((e) => Movie.fromSnapshop(e)).toList();

    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        CircleSlider(movies: movies),
        BoxSlider(movies: movies),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

// 상단바는 홈 화면에서만 사용되기 때문에 여기서 바로 만듬
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'images/joyuri_offcl.png',
              fit: BoxFit.contain,
              height: 25,
            ),
            Container(
                padding: EdgeInsets.only(right: 1),
                child: Text("TV 프로그램", style: TextStyle(fontSize: 14))),
            Container(
                padding: EdgeInsets.only(right: 1),
                child: Text("영화", style: TextStyle(fontSize: 14))),
            Container(
                padding: EdgeInsets.only(right: 1),
                child: Text("내가 찜한 컨텐츠", style: TextStyle(fontSize: 14))),
          ]),
    );
  }
}
