import 'dart:async';

import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:sensors/sensors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  AccelerometerEvent _accele;

  Light _light;
  StreamSubscription _subscription;

  void onData(int luxValue) async {
    setState(() {

      _counter = luxValue;
    });
      // print("Lux value from Light Sensor: $luxValue");
  }

  void catchE() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accele = event;
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
            Text(
              'Lux value from Light Sensor:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$_accele',
              // style: Theme.of(context).textTheme.display1,
            ),            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
