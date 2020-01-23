import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class MenuBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: <Widget>[
            Title(),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  void _onTap(BuildContext context) {
    Navigator.of(context).pushNamed('/info');
  }

  _launchURL() async {
    const url = "https://takeru-e153b.web.app/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap:() {_launchURL();},
            child: Container(
              margin: EdgeInsets.only(top:30),
              child: Image.asset(
                'assets/T.png',
                height: 120,
                width: 120,
                ),
              ),
            )
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(top:30),
            child: Image.asset(
              'assets/K.png',
              height: 120,
              width: 120,
              ),
            ),
        ),   
      ],
    );
  }
}