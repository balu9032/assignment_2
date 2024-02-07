import 'package:assignment_2/functions/get_current_location.dart';
import 'package:assignment_2/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/directions.dart' as directions;

class FindLocation extends StatefulWidget {
  const FindLocation({super.key, required this.currentlocation});
  final LatLng? currentlocation;

  @override
  State<FindLocation> createState() => _FindLocationState();
}

class _FindLocationState extends State<FindLocation> {
  GoogleMapController? mapcontroller;
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  LatLng? pinPosition;
  LatLng? currentLocation;
  LatLng? pinnedPositionValues;

  @override
  void dispose() {
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void onMapCreated(GoogleMapController controller) {
    mapcontroller = controller;
  }

  void getCoordinatesPointOnMap(LatLng position) {
    setState(
      () {
        latitudeController.text = position.latitude.toStringAsFixed(6);
        longitudeController.text = position.longitude.toStringAsFixed(6);
        pinPosition = LatLng(position.latitude, position.longitude);
        mapcontroller
            ?.animateCamera(CameraUpdate.newLatLngZoom(pinPosition!, 15.0));
      },
    );
  }

  void pinCoordinatesOnMap() {
    double? latitude = double.tryParse(latitudeController.text);
    double? longitude = double.tryParse(longitudeController.text);

    if (latitude != null && longitude != null) {
      setState(() {
        pinPosition = LatLng(latitude, longitude);
      });
      mapcontroller
          ?.animateCamera(CameraUpdate.newLatLngZoom(pinPosition!, 15.0));
    } else {
      snackbarController = Get.snackbar(
        'Alert',
        'Invalid Coordinates',
        duration: const Duration(milliseconds: 1000),
      );
    }
  }

  // void getDirections() async {
  //   directions.GoogleMapsDirections directionsService =
  //       directions.GoogleMapsDirections(
  //           apiKey: 'AIzaSyCKrPfj8CjnmTL8uGNB_kgSOwDXzIpIVRY');
  //   final directions.GoogleResponse directionsResponse =
  //       await directionsService.directions(origin, destination);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Maps'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 100),
          child: FloatingActionButton(
            onPressed: () async {
              pinPosition = await getCurrentLocation();
              setState(() {
                mapcontroller?.animateCamera(
                    CameraUpdate.newLatLngZoom(pinPosition!, 15.0));
              });
            },
            child: const Icon(
              Icons.my_location_outlined,
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: latitudeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: longitudeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Copy Coordinates'),
                ),
                ElevatedButton(
                  onPressed: pinCoordinatesOnMap,
                  child: const Text('Search'),
                ),
              ],
            ),
            Expanded(
              child: GoogleMap(
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
                markers: pinPosition == null
                    ? {}
                    : {
                        Marker(
                          markerId: const MarkerId('pin'),
                          position: pinPosition!,
                        ),
                      },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(17.495, 78.3648),
                  zoom: 15.0,
                ),
                onMapCreated: onMapCreated,
                onTap: (LatLng position) => getCoordinatesPointOnMap(position),
              ),
            ),
          ],
        ));
  }
}
