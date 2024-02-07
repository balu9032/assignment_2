import 'package:assignment_2/routes/routes.dart';
import 'package:assignment_2/screens/display_screen.dart';
import 'package:assignment_2/screens/home_screen.dart';
import 'package:assignment_2/screens/maps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final getPages = [
    GetPage(name: Routes.screen1, page: () => const HomeScreen()),
    GetPage(name: Routes.screen2, page: () => DisplayScreen()),
    GetPage(
        name: Routes.screen3,
        page: () => const FindLocation(
              currentlocation: null,
            ))
  ];
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Assignment _2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.screen1,
      getPages: getPages,
    );
  }
}
