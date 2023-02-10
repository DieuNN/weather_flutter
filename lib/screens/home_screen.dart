import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_flutter/screens/search_screen.dart';

import '../components/main_info.dart';
import '../components/mirror_info.dart';
import '../components/search_bar.dart';
import '../components/sun_info.dart';
import '../data/api.dart';
import '../data/model/api_response.dart';
import '../data/model/local_city.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var localCity = Get.find<SearchBarController>().localCity;
  Future<APIResponse?> apiResponse = API().getData("-6.2146", "106.8451");
  var num = 1;


  @override
  Widget build(BuildContext context) {
    // print(localCity.value?.city);
    localCity.listen((p0) {
      setState(() {
        apiResponse = API()
            .getData(p0?.lat.toString() as String, p0?.lng.toString() as String);

      });
    });
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: apiResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  SearchBar(),
                  MainInfo(snapshot.data, localCity.value),
                  MirrorInfo(snapshot.data),
                  SunInfo(snapshot.data),
                ]);
              } else if (snapshot.hasError) {
                return Column(children: [
                  SearchBar(),
                  MainInfo(null, null),
                  MirrorInfo(null),
                  SunInfo(null),
                ]);
              } else {
                return Column(
                  children: [
                    SearchBar(),
                    MainInfo(null, null),
                    MirrorInfo(null),
                    SunInfo(null),
                  ],
                );
              }
              ;
            },
          ),
        ),
      ),
    );
  }
}
