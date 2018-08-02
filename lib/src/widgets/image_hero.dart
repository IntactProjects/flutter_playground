import 'package:flutter/material.dart';

class ImageHero extends StatelessWidget {
  final String tag;
  final String image;
  final double height;
  final double width;

  const ImageHero(
      {Key key,
      @required this.tag,
      @required this.image,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Image.network(
        image,
        height: height,
        width: width,
      ),
    );
  }
}
