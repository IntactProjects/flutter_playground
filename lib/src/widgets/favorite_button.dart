import 'package:flutter/material.dart';

typedef void FavoriteButtonCallback(bool favorite);

class FavoriteButton extends StatefulWidget {
  final bool initialFavorite;
  final FavoriteButtonCallback callback;

  const FavoriteButton({
    Key key,
    this.initialFavorite,
    this.callback,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() {
    return _FavoriteButtonState();
  }
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool favorite;

  @override
  void initState() {
    super.initState();
    favorite = widget.initialFavorite;
  }

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    favorite = widget.initialFavorite;
  }

  @override
  Widget build(BuildContext context) {
    var icon = favorite ? Icons.star : Icons.star_border;
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        setState(() {
          widget.callback(favorite);
          favorite = !favorite;
        });
      },
    );
  }
}
