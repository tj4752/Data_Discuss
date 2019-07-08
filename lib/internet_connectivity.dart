import 'dart:async';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:connectivity/connectivity.dart';

class internet extends StatefulWidget {
  @override
  _internet createState() => new _internet();
}

class _internet extends State<internet>{
  var connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        Navigator.pop(context);
      }
      else{
      }
    });
  }
  @override
  void dispose(){
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Container(
          child: Column(
            children: <Widget> [
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  margin: const EdgeInsets.only(
                    top: 120
                  ),
                  child: IconButton(
                      icon: new Image.asset('assets/pika.png')),
                )
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20
                ),
                  child: Text(
                    "No Internet Connection",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,  fontFamily: 'Montserrat' , color: Colors.black),
                  )
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 10
                  ),
                  child: Text(
                    "Check your Wi-Fi and Mobile Connection",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,  fontFamily: 'Montserrat' , color: Colors.black),
                  )
              )
            ]
          )
        ),
      )
    );
  }
}