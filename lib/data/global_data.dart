import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'model/local_city.dart';
import 'dart:convert';

class GlobalData {
  static List<LocalCity> localCities = [];

  static void loadLocalCities() async {
    final time = DateTime.now().millisecond;
    final input = await rootBundle.loadString("assets/city_data.json");
    final map = jsonDecode(input);
    for(final item in map) {
      localCities.add(LocalCity.fromJson(item));
    }
    print("Parse done! in ${time - DateTime.now().millisecond}");
  }
}
