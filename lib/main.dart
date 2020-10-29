import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:latlong/latlong.dart';
import 'package:trufi_core/trufi_app.dart';
import 'package:trufi_core/trufi_configuration.dart';

import 'package:hamburg_bike_app/localization.dart';

import 'localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final trufiCfg = TrufiConfiguration();
  final globalCfg = GlobalConfiguration();
  await globalCfg.loadFromAsset("app_config");

  // Abbreviations
  trufiCfg.abbreviations.addAll({
    "Avenida": "Av.",
    "Calle": "C.",
    "Camino": "C.º",
  });

  // Animation
  trufiCfg.animation.loading = FlareActor(
    "assets/images/loading.flr",
    animation: "Trufi Drive",
  );
  trufiCfg.animation.success = FlareActor(
    "assets/images/success.flr",
    animation: "Untitled",
  );

  // Attribution
  trufiCfg.attribution.representatives.addAll([
    "Christoph Hanser",
    "Samuel Rioja",
  ]);
  trufiCfg.attribution.team.addAll([
    "Andreas Helms",
    "Annika Bock",
    "Christian Brückner",
    "Javier Rocha",
    "Luz Choque",
    "Malte Dölker",
    "Martin Kleppe",
    "Michael Brückner",
    "Natalya Blanco",
    "Neyda Mili",
    "Raimund Wege",
  ]);
  trufiCfg.attribution.translations.addAll([
    "Gladys Aguilar",
    "Jeremy Maes",
    "Gaia Vitali Roscini",
  ]);
  trufiCfg.attribution.routes.addAll([
    "Trufi team",
    "Guia Cochala team",
  ]);
  trufiCfg.attribution.osm.addAll([
    "Marco Antonio",
    "Noémie",
    "Philipp",
    "Felix D",
    "Valor Naram", // Sören Reinecke
  ]);

  // Email
  trufiCfg.email.feedback = globalCfg.getValue("emailFeedback");
  trufiCfg.email.info = globalCfg.getValue("emailInfo");

  // Image
  trufiCfg.image.drawerBackground = "assets/images/drawer-bg.jpg";

  // Map
  trufiCfg.map.satelliteMapTypeEnabled = true;
  trufiCfg.map.terrainMapTypeEnabled = true;
  trufiCfg.map.mapTilerKey = globalCfg.getValue("mapTilerKey");
  trufiCfg.map.defaultZoom = 12.0;
  trufiCfg.map.offlineMinZoom = 8.0;
  trufiCfg.map.offlineMaxZoom = 14.0;
  trufiCfg.map.offlineZoom = 13.0;
  trufiCfg.map.onlineMinZoom = 1.0;
  trufiCfg.map.onlineMaxZoom = 19.0;
  trufiCfg.map.onlineZoom = 13.0;
  trufiCfg.map.chooseLocationZoom = 16.0;
  trufiCfg.map.center = LatLng(53.551086, 9.993682);
  trufiCfg.map.southWest = LatLng(53.331927, 9.604565);
  trufiCfg.map.northEast = LatLng(53.767577, 10.322638);

  // Languages
  trufiCfg.languages.addAll([
    TrufiConfigurationLanguage(
      languageCode: "de",
      countryCode: "DE",
      displayName: "Deutsch",
    ),
    TrufiConfigurationLanguage(
      languageCode: "en",
      countryCode: "US",
      displayName: "English",
      isDefault: true,
    ),
    /*
    TrufiConfigurationLanguage(
      languageCode: "es",
      countryCode: "ES",
      displayName: "Español",
    ),
    TrufiConfigurationLanguage(
      languageCode: "fr",
      countryCode: "FR",
      displayName: "Français",
    ),
    TrufiConfigurationLanguage(
      languageCode: "it",
      countryCode: "IT",
      displayName: "Italiano",
    ),
    TrufiConfigurationLanguage(
      languageCode: "qu",
      countryCode: "BO",
      displayName: "Quechua simi",
    ),
    */
  ]);

  // Url
  trufiCfg.url.otpEndpoint = globalCfg.getValue("urlOtpEndpoint");
  trufiCfg.url.tilesStreetsEndpoint = globalCfg.getValue("urlTilesStreetsEndpoint");
  trufiCfg.url.tilesSatelliteEndpoint = globalCfg.getValue("urlTilesSatelliteEndpoint");
  trufiCfg.url.tilesTerrainEndpoint = globalCfg.getString("urlTilesTerrainEndpoint");
  trufiCfg.url.adsEndpoint = globalCfg.getValue("urlAdsEndpoint");
  trufiCfg.url.routeFeedback = globalCfg.getValue("urlRouteFeedback");
  trufiCfg.url.donate = globalCfg.getValue("urlDonate");
  trufiCfg.url.website = globalCfg.getValue("urlWebsite");
  trufiCfg.url.facebook = globalCfg.getValue("urlFacebook");
  trufiCfg.url.twitter = globalCfg.getValue("urlTwitter");
  trufiCfg.url.instagram = globalCfg.getValue("urlInstagram");
  trufiCfg.url.share = globalCfg.getValue("urlShare");
  

  // Features
  trufiCfg.features.showCarRouteOnTansitError = false;
  trufiCfg.features.useBikeRoutes = true;

  // Run app
  runApp(
    TrufiApp(
      theme: ThemeData(
        primaryColor: const Color(0xff005ca9),
        primaryColorLight: const Color(0xffeceff1),
        accentColor: const Color(0xffec0016),
        backgroundColor: Colors.white,
      ),
      localization: Localization(),
    ),
  );
}
