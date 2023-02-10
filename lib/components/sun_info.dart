import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_flutter/data/model/api_response.dart';

class SunInfo extends StatefulWidget {
  APIResponse? response;

  @override
  State<SunInfo> createState() => _SunInfoState();

  SunInfo(this.response, {super.key});
}

class _SunInfoState extends State<SunInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SUNRISE & SUNSET",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "Sunrise",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                widget.response?.sys?.sunrise == null
                    ? "No data"
                    : DateFormat.Hm()
                    .format(DateTime.fromMillisecondsSinceEpoch(
                    int.parse(
                        ((widget.response?.sys?.sunrise as int) * 1000)
                            .toString() as String),
                    isUtc: true).add(Duration(hours: (widget.response?.timezone as int) ~/ 3600)))
                    .toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "Sunset",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                widget.response?.sys?.sunset == null
                    ? "No data"
                    : widget.response?.sys?.sunrise == null
                    ? "No data"
                    : DateFormat.Hm()
                    .format(DateTime.fromMillisecondsSinceEpoch(
                    int.parse(
                        ((widget.response?.sys?.sunset as int) * 1000)
                            .toString()),
                    isUtc: true).add(Duration(hours: (widget.response?.timezone as int) ~/ 3600)))
                    .toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )
            ],
          )
        ],
      ),
    );
  }
}
