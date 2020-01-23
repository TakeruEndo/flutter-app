import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:sensors/sensors.dart';
class LightArtScreen extends StatefulWidget {

  @override
  _LightArtScreenState createState() => _LightArtScreenState();
}

class _LightArtScreenState extends State<LightArtScreen> {

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

  void onData(int luxValue) async {
    setState(() {
      _luxValue = luxValue;
    });
  }

  // 速度の取得はなんかメモリーオーバーフローしそうで怖い
  void catchE() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      // setState(() {
        _accele_x = event.x;
      // });      
    });  
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
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
        title: Text("Light Art"),
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
    );
  }
}