import 'dart:async';

import 'package:flutter_playground/models.dart' hide Location;
import 'package:location/location.dart';

class GeolocationService {
  Future<Geolocation> getLocation() {
    return Location().getLocation.then((data) => Geolocation(
          latitude: data['latitude'],
          longitude: data['longitude'],
        ));
  }
}
