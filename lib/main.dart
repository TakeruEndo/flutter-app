import 'package:flutter/material.dart';
import 'weather.dart';
import 'light_art.dart';
import 'menu_bar.dart';
import 'custom.dart';
import 'create_new_task.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/weather': (context) => WeatherScreen(),
        '/light': (context) => LightArtScreen(),
        '/menu_bar': (context) => MenuBar(),
        '/custom': (context) => CustomScreen(),
        '/create_task': (context) => CreateTaskScreen(),
      },      
      home: HomeScreen(title: 'Flutter Art Work'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.dehaze),
            color: Colors.white,
            onPressed: () => Navigator.pushNamed(context, '/menu_bar')
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            WorkBox(
              '/weather',
              '天気',
              Icons.wb_cloudy,
              Colors.blue,
              "現在の天気を表示するアプリケーション。ただし天気の予報機能は未実装。",
            ),
            WorkBox(
              '/light',
              '光のアート',
              Icons.lightbulb_outline,
              Colors.yellow,
              "光の強さによって動作を変えるアプリケーション。",
            ),
            WorkBox(
              '/custom',
              '革新的チェックリスト',
              Icons.calendar_today,
              Colors.red,
              "ぜったいにタスクを見逃さない。毎日のtodoリスト。",
            )            
          ],
        ),
      ),
    );
  }
}

class WorkBox extends StatefulWidget{
  /// Constructor for [WorkBox]
  WorkBox(
      this.root,
      this.title,
      this.icon,
      this.iconColor,
      this.description)
      : assert(root != null);  

  final String root;

  final String title;

  final IconData icon;

  final Color iconColor;

  final String description;

  @override
  State<WorkBox> createState() => _WorkBoxState();
}

class _WorkBoxState extends State<WorkBox> {

  Widget itemTitle(value, iconName, color) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      child: Row(
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
          ),
          Icon(
            iconName,
            color: color,
            )
        ],
      )
    );
  }

  Widget itemDescription(value) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          height: 2.0
        ),
      )
    );
  }  

  @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, widget.root);
        },
        child :Container(
          margin:
            EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),  
          height: 170,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(20.0),
              )),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                  ),
                  itemTitle(widget.title, widget.icon, widget.iconColor),
                  itemDescription(widget.description)
                ]
          ),
        ),
      );
    }
}