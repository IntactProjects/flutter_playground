import 'package:flutter/material.dart';

typedef void FavoriteButtonCallback(bool favorite);

class FavoriteButton extends StatefulWidget {
  final bool initialFavorite;
  final FavoriteButtonCallback callback;

  const FavoriteButton({
    Key key,
    this.initialFavorite = false,
    this.callback,
  }) : super(key: key);

  @override
  FavoriteButtonState createState() {
    return FavoriteButtonState();
  }
}

class FavoriteButtonState extends State<FavoriteButton> {
  bool favorite;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favorite = widget.initialFavorite;
  }

  @override
  Widget build(BuildContext context) {
    var icon = favorite ? Icons.star : Icons.star_border;
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        setState(() {
          favorite = !favorite;
          widget.callback(favorite);
        });
      },
    );
  }
}
