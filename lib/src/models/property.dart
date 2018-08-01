class Property {
  final double price;
  final String address;
  final String locality;
  final Uri image;
  final int bedrooms;
  final int bathrooms;
  final String summary;

  String get id => "$address";

  const Property({
    this.price,
    this.address,
    this.locality,
    this.image,
    this.bedrooms,
    this.bathrooms,
    this.summary,
  });

  Property.fromJson(Map<String, dynamic> json)
      : assert(json != null),
        price = json['price'],
        address = json['address'],
        locality = json['locality'],
        image = Uri.parse(json['image']),
        bedrooms = json['bedrooms'],
        bathrooms = json['bathrooms'],
        summary = json['summary'];

  Map<String, dynamic> toJson() => {
        'price': price,
        'address': address,
        'locality': locality,
        'image': image.toString(),
        'bedrooms': bedrooms,
        'bathrooms': bathrooms,
        'summary': summary,
      };
}
