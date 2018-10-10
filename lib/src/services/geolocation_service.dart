import 'dart:async';

import 'package:flutter_playground/models.dart' hide Location;
import 'package:location/location.dart';

class GeolocationService {
  final Duration _timeout;

  const GeolocationService({timeout = const Duration(seconds: 5)})
      : assert(timeout != null),
        _timeout = timeout;

  Future<Geolocation> getLocation() {
    // FIXME PlatformException if the permission is refused
    return Location()
        .getLocation()
        .then((data) => Geolocation(
              latitude: data['latitude'],
              longitude: data['longitude'],
            ))
        .timeout(_timeout);
  }
}
