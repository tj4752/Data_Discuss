import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Article>> fetchPost() async {
  http.Response response = await http.get(
      'https://www.datadiscuss.com/ghost/api/v2/content/posts/?key=477da0c526d10b1f39c02185a7');

}

class Article {
  final String id;
  final String title;
  final String image;

  Article({this.id, this.title, this.image});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'].toString(),
        id: json['id'].toString(),
        image: json['featured_image'].toString()
    );
  }
}


