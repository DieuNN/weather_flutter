import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_flutter/data/model/local_city.dart';
import '../screens/search_screen.dart';

class SearchBar extends StatefulWidget {
  SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchBarController());
    return GestureDetector(
      onTap: () {
        controller._getCityFromSearchScreen(context);
      },
      child: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            enabledBorder: InputBorder.none,
            enabled: false,
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            hintText: "Search Location",
            suffixIcon: Icon(Icons.search)),
        onTap: () {},
      ),
    );
  }
}

class SearchBarController extends GetxController {
  final localCity = Rxn<LocalCity>();

  void _getCityFromSearchScreen(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchScreen()));
    localCity.value = result;
    update();
  }
}
