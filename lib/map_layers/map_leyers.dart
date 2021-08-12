import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:trufi_core/l10n/trufi_localization.dart';
import 'package:trufi_core/models/map_tile_provider.dart';

enum MapLayerIds {
  streets,
  light,
  dark,
}

extension LayerIdsToString on MapLayerIds {
  String enumToString() {
    final Map<MapLayerIds, String> enumStrings = {
      MapLayerIds.streets: "Streets",
      MapLayerIds.light: "Light",
      MapLayerIds.dark: "Dark",
    };

    return enumStrings[this];
  }

  String enumToStringDE() {
    final Map<MapLayerIds, String> enumStrings = {
      MapLayerIds.streets: "Straßen",
      MapLayerIds.light: "Licht",
      MapLayerIds.dark: "Dunkel",
    };

    return enumStrings[this];
  }

  String enumToStringEN() {
    final Map<MapLayerIds, String> enumStrings = {
      MapLayerIds.streets: "Streets",
      MapLayerIds.light: "Light",
      MapLayerIds.dark: "Dark",
    };

    return enumStrings[this];
  }
}

Map<MapLayerIds, List<LayerOptions>> mapLayerOptions = {
  MapLayerIds.streets: [
    TileLayerOptions(
      urlTemplate:
          "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}@3x.png",
      subdomains: ["a", "b", "c"],
    ),
  ],
  MapLayerIds.light: [
    TileLayerOptions(
      urlTemplate:
          "https://{s}.basemaps.cartocdn.com/rastertiles/light_all/{z}/{x}/{y}{r}@3x.png",
      subdomains: ["a", "b", "c"],
    ),
  ],
  MapLayerIds.dark: [
    TileLayerOptions(
      urlTemplate:
          "https://{s}.basemaps.cartocdn.com/rastertiles/dark_all/{z}/{x}/{y}{r}@3x.png",
      subdomains: ["a", "b", "c"],
    ),
  ],
};
Map<MapLayerIds, String> layerImage = {
  MapLayerIds.streets: "assets/images/maptype-streets.png",
  MapLayerIds.light: "assets/images/maptype-satellite.png",
  MapLayerIds.dark: "assets/images/maptype-terrain.png",
};

class MapLayer extends MapTileProvider {
  final MapLayerIds mapLayerId;
  final String mapKey;

  MapLayer(this.mapLayerId, {this.mapKey}) : super();

  @override
  List<LayerOptions> buildTileLayerOptions() {
    return mapLayerOptions[mapLayerId];
  }

  @override
  String get id => mapLayerId.enumToString();

  @override
  WidgetBuilder get imageBuilder => (context) => Image.asset(
        layerImage[mapLayerId],
        fit: BoxFit.cover,
      );

  @override
  String name(BuildContext context) {
    final localeName = TrufiLocalization.of(context).localeName;
    return localeName == "en"
        ? mapLayerId.enumToStringEN()
        : mapLayerId.enumToStringDE();
  }
}
