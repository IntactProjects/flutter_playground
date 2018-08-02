import 'package:meta/meta.dart';

class Geolocation {
  final double latitude;
  final double longitude;

  const Geolocation({@required this.latitude, @required this.longitude})
      : assert(latitude != null),
        assert(longitude != null);

  Geolocation.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + latitude.hashCode;
    result = 37 * result + longitude.hashCode;
    return result;
  }

  @override
  bool operator ==(o) =>
      o is Geolocation && latitude == o.latitude && longitude == o.longitude;
}
