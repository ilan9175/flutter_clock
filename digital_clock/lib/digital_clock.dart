// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/presentation/weather_icons_icons.dart';
import 'package:digital_clock/sunset_sunrise.dart';
import 'package:digital_clock/weather.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
};

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      // _timer = Timer(
      //   Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
    });
  }

  Icon findIcon(WeatherCondition weatherCondition) {
    return weatherCondition == WeatherCondition.sunny
        ? Icon(
            Icons.wb_sunny,
            size: MediaQuery.of(context).size.width / 15,
            color: Colors.white,
          )
        : weatherCondition == WeatherCondition.foggy
            ? Icon(
                WeatherIcons.fog_cloud,
                size: MediaQuery.of(context).size.width / 15,
                color: Colors.white,
              )
            : weatherCondition == WeatherCondition.rainy
                ? Icon(
                    WeatherIcons.hail_inv,
                    size: MediaQuery.of(context).size.width / 15,
                    color: Colors.white,
                  )
                : weatherCondition == WeatherCondition.cloudy
                    ? Icon(
                        Icons.wb_cloudy,
                        size: MediaQuery.of(context).size.width / 15,
                        color: Colors.white,
                      )
                    : weatherCondition == WeatherCondition.snowy
                        ? Icon(
                            WeatherIcons.snow_heavy,
                            size: MediaQuery.of(context).size.width / 15,
                            color: Colors.white,
                          )
                        : weatherCondition == WeatherCondition.thunderstorm
                            ? Icon(
                                WeatherIcons.cloud_flash,
                                size: MediaQuery.of(context).size.width / 15,
                                color: Colors.white,
                              )
                            : Icon(
                                WeatherIcons.windy,
                                size: MediaQuery.of(context).size.width / 15,
                                color: Colors.white,
                              );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final date = DateFormat('yyyy, MMM dd').format(_dateTime);
    final city = widget.model.location;
    final fontSize = MediaQuery.of(context).size.width / 3.5;
    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: 'HangedLetters',
      fontSize: fontSize,
      shadows: Theme.of(context).brightness == Brightness.light
          ? [
              Shadow(
                blurRadius: 0,
                color: colors[_Element.shadow],
                offset: Offset(5, 0),
              ),
            ]
          : [],
    );
    final weather = widget.model.weatherCondition;
    final temp = widget.model.temperatureString;
    final highTemp = widget.model.highString;
    final lowTemp = widget.model.lowString;

    return Container(
      color: colors[_Element.background],
      child: Column(
        children: <Widget>[
          DefaultTextStyle(
            style: defaultStyle,
            child: Container(child: Text(hour + ':' + minute)),
          ),
          DefaultTextStyle(
            style: TextStyle(
              color: colors[_Element.text],
              fontFamily: 'Argentum',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width / 20,
            ),
            child: Container(child: Text(date)),
          ),
          DefaultTextStyle(
            style: TextStyle(
              color: colors[_Element.text],
              fontFamily: 'Argentum',
              fontSize: MediaQuery.of(context).size.width / 30,
            ),
            child: Container(child: Text(city)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Weather(findIcon(weather), temp, lowTemp, highTemp),
                SunsetSunrise(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
