import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:weather/weather.dart';

import 'config.dart';


class WeatherScreen extends StatefulWidget {

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Weather celsius;

  // 使いすぎると？
  // OpenWeatherAPIException - OpenWeather API Exception: 
  // {"cod":429, "message": "Your account is temporary blocked due to exceeding of 
  // requests limitation of your subscription type. Please choose the proper subscription 
  // http://openweathermap.org/price"}
  // 
  // WeatherStation weatherStation = WeatherStation(Config.weatherStationApi);

  /// 天気の情報を取得する関数
  Future<int> getWeather() async{
    // Weather weather = await weatherStation.currentWeather();
    // return weather;
    return 300;
  }

  void _bachHomeScreen(BuildContext context) {
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Second Screen"),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<void>(
            future: getWeather(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                    child: Text(snapshot.data.toString())
                );
              } else {
                // URL取得待ちの間
                return Container(
                  alignment: Alignment.center,
                  height: 350,
                  child: CircularProgressIndicator(),
                );
              }
            }
          ),          
        ],
      )
    );
  }
}