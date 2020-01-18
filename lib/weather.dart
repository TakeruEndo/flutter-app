import 'dart:async';

import 'package:alive/my_flutter_app_icons.dart';
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
  WeatherStation weatherStation = WeatherStation(Config.weatherStationApi);

  var weatherMap = {};

  /// 天気の情報を取得する関数
  Future<Map> getWeather() async{
    Weather weather = await weatherStation.currentWeather();
    weatherMap['temparture'] = weather.temperature.celsius;
    weatherMap['tempMax'] = weather.tempMax;
    weatherMap['tempMin'] = weather.tempMin;
    weatherMap['areaName'] = weather.country + weather.areaName;
    weatherMap['date'] = weather.date;
    weatherMap['sunrise'] = weather.sunrise;
    weatherMap['sunset'] = weather.sunset;
    weatherMap['humidity'] = weather.humidity;
    weatherMap['windSpeed'] = weather.windSpeed;
    weatherMap['main'] = weather.weatherMain;
    return weatherMap;
    // return 300;
  }

  void _backHomeScreen(BuildContext context) {
    Navigator.pop(context);
  }

  Widget itemBase(itemName, value) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(4)
            ),
            Expanded(
              flex: 4,
              child: Text(
                itemName,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 2.0
                ),
              )
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  String _getWeatherImagePath(weather){
    switch (weather){
      case "Clear":
        return 'assets/sunny2.jpg';
        break;
      case "Rain":
        return 'assets/rain1.jpg';
        break;
      case "Snow":
        return 'assets/snow1.jpg';
        break;
      case "Extreme":
        return 'assets/sunny2.jpg';
        break;
      case "Thunder":
        return 'assets/thunder.jpg';
        break;
      case "Drizzle":
        return 'assets/sunny2.jpg';
        break;
      case "Cloudy":
        return 'assets/cloudy1.jpg';
        break;  
      default:
        return 'assets/cloudy1.jpg';
        break;                                            
    }
  }

  Icon getIcon(weather){
    switch (weather){
      case "Clear":
        return 
        Icon(
          Icons.wb_sunny,
          size: 65,
          color: Colors.red,
        );
        break;
      case "Rain":
        return Icon(
          MyFlutterApp.umbrella,
          size: 65,
          color: Colors.blue,
        );
        break;
      case "Snow":
        return Icon(
          MyFlutterApp.snow,
          size: 65,
          color: Colors.white,
        );
        break;
      case "Extreme":
        return Icon(
          MyFlutterApp.attention,
          size: 65,
          color: Colors.yellow,
        );
        break;
      case "Thunder":
        return Icon(
          MyFlutterApp.cloud_thunder,
          size: 65,
          color: Colors.yellow,
        );
        break;
      case "Drizzle":
        return Icon(
          MyFlutterApp.drizzle,
          size: 65,
          color: Colors.white,
        );
        break;
      case "Clouds":
        return Icon(
          Icons.wb_cloudy,
          size: 65,
          color: Colors.white,
        );
        break;
      default:
        return Icon(
          Icons.adb,
          size: 65,
          color: Colors.green,
        );
        break;                                         
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Wether News"),
        // centerTitle: true,
      ),
      body: FutureBuilder<void>(
        future: getWeather(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: Container(
                    width: double.infinity,
                    child : Image.asset(
                      _getWeatherImagePath(weatherMap["main"]),
                      fit: BoxFit.fill,
                    )
                  )
                ),
                Container(
                  margin:
                    EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 10),
                  padding:
                    EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 20),
                  width: 405,
                  // height: 300,
                  color: Colors.black38,
                  alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        getIcon(weatherMap["main"]),
                        Container(
                          margin:
                          EdgeInsets.only(top: 10),
                        ),
                        itemBase("weather", weatherMap["main"].toString()),
                        itemBase("location", weatherMap["areaName"].toString()),
                        itemBase("date", weatherMap["date"].toString()),
                        itemBase("temparture", weatherMap["temparture"].toString()),
                        itemBase("temparture(min)", weatherMap["tempMax"].toString()),
                        itemBase("temparture(max)", weatherMap["tempMin"].toString()),
                        itemBase("sunrise", weatherMap["sunrise"].toString()),
                        itemBase("sunset", weatherMap["sunset"].toString()),
                        itemBase("humidity", weatherMap["humidity"].toString()),
                        itemBase("wind-speed", weatherMap["windSpeed"].toString()),
                        Container(
                        margin:
                          EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),                          
                          child: Text(
                            "冬にしてはあったかい。コートは薄めでいいかも！？！？",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                          height: 50,
                          color: Colors.lightBlue,
                        )
                      ],
                    )
                ),
              ],
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
    );
  }
}