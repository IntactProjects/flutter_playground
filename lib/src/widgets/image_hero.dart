import 'package:flutter/material.dart' hide ImageInfo;
import 'package:flutter_playground/models.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageHero extends StatelessWidget {
  final String tag;
  final String placeholder;
  final String url;
  final double height;
  final double width;

  const ImageHero(
      {Key key,
      @required this.tag,
      @required this.url,
      this.placeholder = "",
      this.width,
      this.height})
      : super(key: key);

  ImageHero.fromImage(
      {@required String tag, @required ImageInfo image, ImageInfo placeholder})
      : this(
          tag: tag,
          url: image.uri.toString(),
          placeholder: placeholder?.uri?.toString() ?? "",
          width: image.width,
          height: image.height,
        );

  @override
  Widget build(BuildContext context) {
    return Hero(tag: tag, child: _createCachedImage(url, placeholder));
  }

  Widget _createCachedImage(String url, [String placeholder = ""]) {
    return placeholder.isEmpty
        ? CachedNetworkImage(
            imageUrl: this.url,
            width: width,
            height: height,
          )
        : CachedNetworkImage(
            imageUrl: this.url,
            width: width,
            height: height,
            placeholder: CachedNetworkImage(
              imageUrl: placeholder,
              width: width,
              height: height,
            ),
          );
  }
}
