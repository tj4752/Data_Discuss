import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

Future<Article> fetchPost() async {
  final response =
  await http.get('https://www.datadiscuss.com/ghost/api/v2/content/posts/?key=477da0c526d10b1f39c02185a7');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Article.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class Article{
  final String id;
  final String title;
  final String image;

  Article({this.id, this.title, this.image});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['posts'][0]['title'],
        id: json['posts'][0]['id'],
        image: json['posts'][0]['feature_image']
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Future<Article> title;
  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: new Image.asset('assets/datadiscuss.png'),
            color: Colors.black,
            onPressed: () {},
          ),
          title: new Text('DataDiscuss',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: PopupMenuButton<String>(
                icon: new Icon(Icons.more_vert, color: Colors.black),
                itemBuilder: (BuildContext context){
                  return Constants.choices.map((String choice){
                    return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice)
                    );
                  }).toList();
                },
              ),
            )
          ],
        ),
        body: Center(
          child: SwipeList())
    );
  }
}

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  List items = getDummyList();

  @override
  Widget build(BuildContext context) {
            return Container(
                child: FutureBuilder<Article>(
                future: fetchPost(), //sets the getQuote method as the expected Future
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Center(
          child: ListView.builder(

            itemCount: items.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(items[index]),
                background: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    items.removeAt(index);
                  });
                },
                direction: DismissDirection.endToStart,
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    height: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                    child: Column(
                      children: <Widget>[
                      Container(
                        height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0)
                        ),
                          image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1501621667575-af81f1f0bacc?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ'), fit: BoxFit.cover)
                      ),
                      )
                    ],
                ),
                  )
                ));
            },
          )
      );
    }})
 );
          }
        }


   List getDummyList() {
    List list = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }
