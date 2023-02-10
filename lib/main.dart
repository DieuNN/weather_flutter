import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_flutter/components/search_bar.dart';
import 'package:weather_flutter/data/global_data.dart';
import 'package:weather_flutter/screens/home_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  putDependencies();
  runApp(const MyApp());
  GlobalData.loadLocalCities();
  await GetStorage.init();
  // Init box if empty
  final box = await GetStorage();
  if (box.read("recent") == null) {
    await box.write("recent", "");
  }
}

void putDependencies() {
  Get.put(SearchBarController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(child: HomeScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
