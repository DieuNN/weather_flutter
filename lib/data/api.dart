import 'dart:convert';

import 'package:weather_flutter/data/model/api_response.dart';
import 'package:http/http.dart';

class API {
  Future<APIResponse?> getData(String lat, String long) async {
    final response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=cf58d530508a2e92363fbf293d230cf2&units=metric"));
    print(response.body);
    if (response.statusCode == 200) {
      return APIResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
