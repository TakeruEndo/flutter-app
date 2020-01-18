import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:sensors/sensors.dart';
import 'weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/weather': (context) => WeatherScreen(),
      },      
      home: HomeScreen(title: 'Flutter Demo Home Page'),
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
  // 光の強さ
  int _luxValue = 0;
  // x方向の加速度
  double _accele_x;
  // y方向の加速度
  double _accele_y;
  // z方向の加速度
  double _accele_z;
  // 現在日時
  final now = DateTime.now();

  Light _light;
  StreamSubscription _subscription;

  String _time = '';

  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 1),
      _onTimer,
    );
    super.initState();
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    var formattedTime = formatter.format(now);
    setState(() => _time = formattedTime);
  }

  void onData(int luxValue) async {
    setState(() {

      _luxValue = luxValue;
    });
      // print("Lux value from Light Sensor: $luxValue");
  }

  void catchE() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accele_x = event.x;
      });      
    });  
  }

  void startListening() {
      _light = new Light();
      try {
        _subscription = _light.lightSensorStream.listen(onData);
      }
      on LightException catch (exception) {
        print(exception);
      }
  }

  int change_bligtness(light){
    if (light < 50){
      return 50;
    }else if(light >= 50 && light < 150){
      return 100;
    }else if(light >= 150 && light < 250){
      return 200;
    }else if(light >= 250 && light < 350){
      return 300;
    }else if(light >= 450 && light < 550){
      return 400;
    }else if(light >= 650 && light < 750){
      return 500;
    }else if(light >= 750 && light < 850){
      return 600;
    }else if(light >= 850 && light < 950){
      return 700;
    }else if(light >= 50 && light < 150){
      return 800;
    }else{
      return 900;
    }
  }

  @override
  Widget build(BuildContext context) {
    startListening();
    catchE();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 300,
              height: 300,
              color: Colors.lightBlue[change_bligtness(_luxValue)],
            ),
            Text(
              'Lux value from Light Sensor:',
            ),
            Text(
              '$_luxValue',
              style: Theme.of(context).textTheme.display1,
            ),
            // Text(
            //   '$_onTimer',
            //   // style: Theme.of(context).textTheme.display1,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            Navigator.pushNamed(context, '/weather');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
