import 'package:flutter/material.dart' hide ImageInfo;
import 'package:flutter_playground/models.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageHero extends StatelessWidget {
  final String tag;
  final String url;
  final double height;
  final double width;

  const ImageHero(
      {Key key,
      @required this.tag,
      @required this.url,
      this.width,
      this.height})
      : super(key: key);

  ImageHero.fromImage({@required String tag, @required ImageInfo image})
      : this(
          tag: tag,
          url: image.uri.toString(),
          width: image.width,
          height: image.height,
        );

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        height: height,
        width: width,
      ),
    );
  }
}
