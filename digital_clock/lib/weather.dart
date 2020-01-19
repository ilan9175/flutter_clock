import 'package:flutter/material.dart';

class Weather extends StatelessWidget {

  final Icon iconWeather;
  final String temp;
  final String lowTemp;
  final String highTemp;

  Weather(this.iconWeather, this.temp, this.lowTemp, this.highTemp);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          iconWeather,
          SizedBox(width: 10,),
          Column(
            children: <Widget>[
              DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Argentum',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 30,
                ),
                child: Text(temp),
              ),
              DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Argentum',
                  fontSize: MediaQuery.of(context).size.width / 45,
                ),
                child: Text('Min: ' + lowTemp),
              ),
              DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Argentum',
                  fontSize: MediaQuery.of(context).size.width / 45,
                ),
                child: Text('Max: ' + highTemp),
              ),
            ],
          ),
        ],
      )
    );
  }
}
