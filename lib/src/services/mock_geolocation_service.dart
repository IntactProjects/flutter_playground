import 'dart:async';

import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';

const _london = Geolocation(latitude: 51.50853, longitude: -0.076132);

class MockGeolocationService implements GeolocationService {
  @override
  Future<Geolocation> getLocation() {
    return Future.delayed(Duration(seconds: 1), () => _london);
  }
}
