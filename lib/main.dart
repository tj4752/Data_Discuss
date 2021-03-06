import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'blogpage.dart';
import 'auto_size_text.dart';
import 'splash_screen.dart';

void main() => runApp(new MyApp());

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyHomePage(),
  "/blogs": (BuildContext context) => blogpage(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: routes
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url =
      'https://www.datadiscuss.com/ghost/api/v2/content/posts/?key=477da0c526d10b1f39c02185a7';
  List data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["posts"];
    });
  }
  @override
  void initState() {
    this.makeRequest();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
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
            IconButton(icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: (){
              showSearch(context: context, delegate: DataSearch(data));
                }),
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
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, i) {
            return Container(
                child: new GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => blogpage(content: data[i])),
                    );
                  },
                    child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.only(
                          left: 10,
                          top: 15,
                          right: 10,
                          bottom: 15
                        ),

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          height: 300.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 220,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(20.0),
                                        topRight: const Radius.circular(20.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            data[i]['feature_image']),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                height: 25,
                                child: AutoSizeText('Data Science',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                maxLines: 2),
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                    left: 10,
                                    top: 5
                                ),
                              ),
                              Container(
                                height: 50,
                                child: AutoSizeText(data[i]['title'],
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                maxLines: 2),
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                    left: 10
                                ),
                              )
                            ],
                          ),
                        ))
                ),
                );
          },
        ));
  }
}



class DataSearch extends SearchDelegate<String>{
List data;
List<String> titles = [];
DataSearch(this.data);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          titles.add(data[index]['title']);
          List suggestionList = query.isEmpty ?
              titles :
              titles.where((p) => p.startsWith(query)).toList();
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40.0,
              child: Image.network(data[index]['feature_image']),
            ),
            title: Text(suggestionList[index]),
          );
    }
    );
  }

}
