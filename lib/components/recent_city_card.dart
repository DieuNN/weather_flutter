import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather_flutter/data/model/local_city.dart';

class RecentCityCard extends StatelessWidget {
  String cityName;
  LocalCity localCity;

  RecentCityCard(this.cityName, this.localCity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(cityName),
        ),
        onTap: () {
          Navigator.pop(context, localCity);
        },
      ),
    );
  }
}
