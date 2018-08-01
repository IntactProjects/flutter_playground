import 'package:flutter/widgets.dart';
import 'package:flutter_playground/infra.dart';

class Provider extends InheritedWidget {
  static Provider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Provider);

  final ProviderConfig _config;
  PropertyService get propertyService => _config.propertyService;
  GeolocationService get geolocationService => _config.geolocationService;
  FavoriteService get favoriteService => _config.favoriteService;
  RecentService get recentService => _config.recentService;

  Provider({
    Key key,
    @required ProviderConfig config,
    Widget child,
  })  : _config = config,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class ProviderConfig {
  final PropertyService propertyService;
  final GeolocationService geolocationService;
  final FavoriteService favoriteService;
  final RecentService recentService;

  ProviderConfig({
    @required this.propertyService,
    @required this.geolocationService,
    @required this.favoriteService,
    @required this.recentService,
  })  : assert(propertyService != null),
        assert(geolocationService != null),
        assert(favoriteService != null),
        assert(recentService != null);
}
