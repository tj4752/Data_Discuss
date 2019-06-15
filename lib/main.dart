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
                  child: Container(
                    height: 300.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 200.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5)
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(snapshot.data.image)
                              )
                          ),
                        ),
                        Container(
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  items[index],

                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                  child: Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.teal),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Text(snapshot.data.id,textAlign: TextAlign.center,),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Container(
                                    width: 260,
                                    child: Text(snapshot.data.title,style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)

                                    ),),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
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
