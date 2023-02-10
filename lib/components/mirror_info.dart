import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_flutter/data/model/api_response.dart';

class MirrorInfo extends StatefulWidget {
  APIResponse? response;

  MirrorInfo(this.response, {super.key});

  @override
  State<MirrorInfo> createState() => _MirrorInfoState();
}

class _MirrorInfoState extends State<MirrorInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                "LOCAL TIME",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                widget.response?.dt == null
                    ? "No data"
                    : DateFormat.Hm()
                    .format(DateTime.fromMillisecondsSinceEpoch(
                    int.parse(
                        ((widget.response?.dt as int) * 1000)
                            .toString() as String),
                    isUtc: true).add(Duration(hours: ((widget.response?.timezone as int) / 3600).toInt())))
                    .toString(),
                  style: TextStyle(fontSize: 15)
              ),
            ],
          ),
          Column(
            children: [
              Text("FEELS LIKE",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(
                height: 8,
              ),
              Text(
                widget.response?.main?.feelsLike == null
                    ? "No data"
                    : (widget.response?.main?.feelsLike.toString() as String) +
                        "°",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Column(
            children: [
              Text("% CLOUD",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(
                height: 8,
              ),
              Text(
                widget.response?.clouds?.all == null
                    ? "No data"
                    : (widget.response?.clouds?.all as num).toString(),
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Column(
            children: [
              Text("WIND", style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(
                height: 8,
              ),
              Text(
                widget.response?.wind?.speed == null
                    ? "No data"
                    : (widget.response?.wind?.speed as num).toString(),
                style: TextStyle(fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}
