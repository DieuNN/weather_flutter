import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather_flutter/components/search_bar.dart';
import 'package:weather_flutter/data/model/api_response.dart';
import 'dart:developer';

import '../data/model/local_city.dart';

class MainInfo extends StatefulWidget {
  APIResponse? response;
  LocalCity? localCity;

  MainInfo(this.response, this.localCity, {super.key});

  @override
  State<MainInfo> createState() => _MainInfoState();
}

class _MainInfoState extends State<MainInfo> {
  @override
  Widget build(BuildContext context) {
    String json = jsonEncode(widget.response);
    return Container(
      margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Column(
          children: [
            SizedBox(
              child: widget.response?.weather![0].icon == null
                  ? Image.asset("assets/sun.png")
                  : Image.network(
                "http://openweathermap.org/img/wn/${widget.response!.weather![0].icon}@2x.png", fit: BoxFit.fitWidth,),
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    (widget.localCity?.city == null ||
                            widget.localCity?.city == "")
                        ? "No data"
                        : "${widget.localCity?.city}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Transform.rotate(
                  angle: widget.response?.wind?.deg == null
                      ? 0
                      : widget.response!.wind!.deg!.toDouble(),
                  child: Image.asset("assets/wind.png"),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              widget.response == null ?  "No data" : "${widget.response?.main?.temp}°C",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            )
          ],
        ),
      ),
    );
  }
}
