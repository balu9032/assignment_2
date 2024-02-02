import 'package:assignment_2/controllers/inputcontroller.dart';
import 'package:assignment_2/screens/display_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:geolocator/geolocator.dart'; // For geolocation

final UserController userController = Get.put(UserController());
TextEditingController nameEditingController = TextEditingController();
SnackbarController? snackbarController;
String inputname = '';
var location = '';
var imagelocation = '';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('First Page'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  TextField(
                    controller: userController.name.value == ''
                        ? null
                        : nameEditingController,
                    autofocus: true,
                    decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Name'),
                    onChanged: (value) {
                      userController.name.value = value;
                      inputname = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Pick Profile Picture'),
                    onPressed: () async {
                      final pickedImage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        // snackbarController?.close();
                        snackbarController = Get.snackbar(
                          'Status',
                          'Image upload success',
                          duration: const Duration(milliseconds: 1000),
                        );
                        userController.profilePicture.value = pickedImage.path;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Get Geo Location'),
                    onPressed: () async {
                      try {
                        final position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        // snackbarController?.close();
                        snackbarController = Get.snackbar(
                          'Status',
                          'Geo Location fetch and upload success',
                          duration: const Duration(milliseconds: 1000),
                        );

                        userController.geoLocation.value =
                            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                        location = position.toString();
                      } catch (error) {
                        // Handle error
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      if (userController.name.isNotEmpty ||
                          userController.geoLocation.isNotEmpty ||
                          userController.profilePicture.isNotEmpty) {
                        Get.offAll(DisplayScreen());
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
