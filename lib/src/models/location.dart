import 'package:meta/meta.dart';

class Location {
  final String key;
  final String label;

  Location({@required this.key, @required this.label})
      : assert(key != null),
        assert(label != null);

  Location.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        label = json['label'];

  Map<String, dynamic> toJson() => {
        'key': key,
        'label': label,
      };

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + key.hashCode;
    result = 37 * result + label.hashCode;
    return result;
  }

  @override
  bool operator ==(o) => o is Location && key == o.key && label == o.label;
}
