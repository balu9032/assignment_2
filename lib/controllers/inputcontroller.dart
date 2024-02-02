import 'package:get/get.dart';

class UserController extends GetxController {
  final name = ''.obs;
  final profilePicture = ''.obs;
  final geoLocation = ''.obs;
  void deleteData() {
    name.value = '';
    profilePicture.value = '';
    geoLocation.value = '';
  }
  // void updateUserInfo(
  //     String newName, String newProfilePicture, String newGeoLocation) {
  //   name.value = newName;
  //   profilePicture.value = newProfilePicture;
  //   geoLocation.value = newGeoLocation;
  //   update();
  // }
}
