import 'package:flutter/material.dart';

class SunsetSunrise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                'assets/images/sunrise.png',
                width: MediaQuery.of(context).size.width / 22,
                height: MediaQuery.of(context).size.width / 22,
                color: Colors.white,
              ),
              DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Argentum',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 40,
                ),
                child: Text(' 07:12'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Image.asset(
                'assets/images/sunset.png',
                width: MediaQuery.of(context).size.width / 22,
                height: MediaQuery.of(context).size.width / 22,
                color: Colors.white,
              ),
              DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Argentum',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 40,
                ),
                child: Text(' 17:54'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
