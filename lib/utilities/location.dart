import 'package:geolocator/geolocator.dart';

class Location {
  var latitude;
  var longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      throw 'Somelthing goes wrong: $e';
    }
  }
}
