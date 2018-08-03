class Property {
  final double price;
  final String address;
  final String locality;
  final ImageInfo image;
  final ImageInfo thumb;
  final int bedrooms;
  final int bathrooms;
  final String summary;

  String get id => "$address";

  const Property({
    this.price,
    this.address,
    this.locality,
    this.image,
    this.thumb,
    this.bedrooms,
    this.bathrooms,
    this.summary,
  });

  Property.fromJson(Map<String, dynamic> json)
      : assert(json != null),
        price = json['price'],
        address = json['address'],
        locality = json['locality'],
        image = ImageInfo(
          uri: Uri.parse(json['image'] ?? ""),
          width: json['image_width'],
          height: json['image_height'],
        ),
        thumb = ImageInfo(
          uri: Uri.parse(json['thumb'] ?? ""),
          width: json['thumb_width'],
          height: json['thumb_height'],
        ),
        bedrooms = json['bedrooms'],
        bathrooms = json['bathrooms'],
        summary = json['summary'];

  Map<String, dynamic> toJson() => {
        'price': price,
        'address': address,
        'locality': locality,
        'image': image.uri.toString(),
        'image_width': image.width,
        'image_height': image.height,
        'thumb': thumb.uri.toString(),
        'thumb_width': thumb.width,
        'thumb_height': thumb.height,
        'bedrooms': bedrooms,
        'bathrooms': bathrooms,
        'summary': summary,
      };
}

class ImageInfo {
  final Uri uri;
  final double width;
  final double height;

  const ImageInfo({this.uri, this.width, this.height});
}
