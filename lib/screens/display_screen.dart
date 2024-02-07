import 'dart:io';

import 'package:assignment_2/controllers/inputcontroller.dart';
import 'package:assignment_2/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final UserController userController = Get.find();
var data = Get.arguments;

class DisplayScreen extends StatelessWidget {
  DisplayScreen({super.key});
  final imageurl = userController.profilePicture;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Name: ${userController.name.value}'),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.file(
                    File(userController.profilePicture.toString()),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Geo Location: ${userController.geoLocation}'),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Edit Data'),
                  onPressed: () {
                    Get.offAll(() => const HomeScreen());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Ok, Go Back'),
                  onPressed: () {
                    userController.deleteData();
                    Get.offAll(() => const HomeScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
