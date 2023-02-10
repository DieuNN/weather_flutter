import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/utils.dart';
import 'package:weather_flutter/data/global_data.dart';
import 'package:weather_flutter/data/model/local_city.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import '../components/recent_city_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<LocalCity> _localCities = [];
  List<LocalCity> _filteredLocalCity = [];
  List<dynamic> _recentLocalCity = [];

  @override
  void initState() {
    _localCities = GlobalData.localCities;
    _filteredLocalCity = _localCities;
    _getRecentLocalCity();
    super.initState();
  }

  void _getRecentLocalCity() {
    final box = GetStorage();
    final jsonString = box.read("recent");
    if(jsonString == "") {
      _recentLocalCity = [];
    } else {
      dynamic jsonData = jsonDecode(jsonString);
      _recentLocalCity = jsonData.map((e)=> LocalCity.fromJson(e)).toList();
    }
  }

  void _runFilter(String enteredKeyword) {
    List<LocalCity> result = [];
    if (enteredKeyword.isEmpty) {
      result = _localCities;
    } else {
      result = _localCities
          .where((element) => element.city!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredLocalCity = result;
    });
  }

  void _addToRecent(LocalCity localCity) {
    final recentBox = GetStorage();
    final recentCityAsList = _recentLocalCity.map((e)  {
      return e.toJson();
    }).toList().reversed.take(10).toSet().toList();
    recentCityAsList.add(localCity);
    String jsonString = jsonEncode(recentCityAsList);
    recentBox.write("recent", jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      enabled: true,
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      hintText: "Search Location",
                      suffixIcon: Icon(Icons.search)),
                  onTap: () {},
                  onChanged: (value) {
                    _runFilter(value);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Builder(builder: (context) {
                  if (_recentLocalCity.isEmpty) {
                    return SizedBox.shrink();
                  } else {
                    List<Widget> cards = [];
                    for (var value in _recentLocalCity.toSet().toList()) {
                      cards.add(RecentCityCard(value.city, value));
                    }
                    return Wrap(
                      children: cards,
                    );
                  }
                }),
                SizedBox(
                  height: 16,
                ),
                Expanded(child: Builder(
                  builder: (context) {
                    if (_filteredLocalCity.isEmpty) {
                      return Center(
                        child: Text("No data"),
                      );
                    } else {
                      return ListView.separated(
                        itemCount: _filteredLocalCity.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              "${_filteredLocalCity[index].city}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            onTap: () {
                              _addToRecent(_filteredLocalCity[index]);
                              Navigator.pop(context, _filteredLocalCity[index]);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 16,
                          );
                        },
                        physics: BouncingScrollPhysics(),
                      );
                    }
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
