import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;
  // 실제 Firebase firestore에 있는 데이터 컬럼을 참조할 수 있는 링크
  // 이것을 통해서 해당 데이터에 대한 CRUD를 간단하게 처리할 수 있음
  final DocumentReference? reference;

  // fromMap은 생성자 생성 전에 Map형(딕셔너리)을 먼저 초기화 하는 생성자 메서드이다.
  // Generic 설명 => https://sudarlife.tistory.com/entry/Flutter-%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%A0%9C%EB%84%A4%EB%A6%AD-%EC%A0%9C%EB%84%A4%EB%A6%AD-%ED%95%98%EB%8A%94%EB%8D%B0-%EA%B7%B8%EA%B2%8C-%EB%AD%90%EC%95%BC-%EA%B0%9C%EB%85%90-%EC%82%B4%ED%8E%B4%EB%B3%B4%EA%B8%B0
  Movie.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  Movie.fromSnapshop(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "Movie<$title:$keyword>";
}
