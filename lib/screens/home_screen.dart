import 'package:assignment_2/controllers/inputcontroller.dart';
import 'package:assignment_2/functions/get_current_location.dart';
import 'package:assignment_2/screens/display_screen.dart';
import 'package:assignment_2/screens/maps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:permission_handler/permission_handler.dart'; // For geolocation

final UserController userController = Get.put(UserController());
TextEditingController nameEditingController = TextEditingController();
SnackbarController? snackbarController;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng? currentLocation;

    return MaterialApp(
      home: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => FindLocation(
                    currentlocation: currentLocation,
                  ));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Icon(Icons.merge_sharp),
                  Expanded(
                    child: Text(
                      'Maps',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Input Your details'),
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
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Check location permission status
                      var status = await Permission.location.isGranted;
                      snackbarController = Get.snackbar(
                        'Status',
                        'Location Permission Status: $status',
                        duration: const Duration(milliseconds: 1000),
                      );
                    },
                    child: const Text('Check Location Permission'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      child: const Text('Pick Profile Picture'),
                      onPressed: () async {
                        final source = await showModalBottomSheet<ImageSource>(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('Take a photo'),
                                onTap: () =>
                                    Navigator.pop(context, ImageSource.camera),
                              ),
                              ListTile(
                                title: const Text('Choose from gallery'),
                                onTap: () =>
                                    Navigator.pop(context, ImageSource.gallery),
                              ),
                            ],
                          ),
                        );

                        // If the user selected a source, then pick an image from that source.
                        if (source != null) {
                          final image = await ImagePicker()
                              .pickImage(source: source, imageQuality: 50);
                          if (image != null) {
                            userController.profilePicture.value = image.path;
                          }
                          snackbarController = Get.snackbar(
                            'Status',
                            'Photo upload success',
                            duration: const Duration(milliseconds: 1000),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        currentLocation = await getCurrentLocation();
                        snackbarController = Get.snackbar(
                          'Status',
                          'Geo Location fetch and upload success',
                          duration: const Duration(milliseconds: 1000),
                        );

                        userController.geoLocation.value =
                            'Latitude: ${currentLocation?.latitude}, Longitude: ${currentLocation?.longitude}';
                      },
                      child: const Text('Get Geo Location')),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      Get.offAll(
                        () => DisplayScreen(),
                        // arguments: [inputname.toString()]
                      );
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
