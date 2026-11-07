import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longtitude;

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Службы геолокации отключены.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Разрешение на геолокацию отклонено.';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Геолокация запрещена навсегда в настройках устройства.';
      }

      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.best,
      ).timeout(const Duration(seconds: 15));

      latitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      throw 'Something goes wrong: $e';
    }
  }
}
