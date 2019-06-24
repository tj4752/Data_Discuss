import 'package:flutter/material.dart';
import 'auto_size_text.dart';

final controller = PageController(
  initialPage: 1,
);
final pageView = PageView(
  controller: controller,
  scrollDirection: Axis.vertical,
  children: <Widget>[
    blogpage(),
  ],
);
class blogpage extends StatelessWidget {
  var content;

  blogpage({Key key, @required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.all(8.0),
        children: <Widget>[
        Container(
          width: 360,
          height: 200,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(content['feature_image']),
                      fit: BoxFit.cover)),
            ),
          ),
        ),
        Container(
          width: 360,
          height: 1000,
          child: AutoSizeText(content['html']),
        )
      ])
    );
  }
}
