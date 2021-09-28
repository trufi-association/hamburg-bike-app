import 'package:flutter/material.dart';
import 'package:hamburg_bike_app/bike_app_home/services/bike_graphql_repository.dart';

import 'package:hamburg_bike_app/configuration_service.dart';
import 'package:hamburg_bike_app/map_layers/map_leyers.dart';
import 'package:hamburg_bike_app/theme.dart';
import 'package:trufi_core/trufi_app.dart';

import 'bike_app_home/bike_app_home_page.dart';
import 'drawer_menu/custom_about_page.dart';
import 'drawer_menu/custom_imprint_page.dart';
import 'drawer_menu/drawer_menu.dart';
import 'hive_init.dart';
import 'offline_search_location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(
    TrufiApp(
      theme: stadtnaviTheme,
      bottomBarTheme: bottomBarTheme,
      configuration: setupTrufiConfiguration(),
      mapTileProviders: [
        MapLayer(MapLayerIds.streets),
        MapLayer(MapLayerIds.light),
        // MapLayer(MapLayerIds.dark),
      ],
      menuItems: menuItems,
      customHomePage: BikeAppHomePage(),
      searchLocationManager: CustomOfflineSearchLocation(),
      customRequestManager: BikeGraphQLRepository(
        graphQLEndPoint:
            "https://api.trufi.app/otp-hh/routers/default/index/graphql",
      ),
      routes: <String, WidgetBuilder>{
        CustomAboutPage.route: (context) => const CustomAboutPage(),
        CustomImprintPage.route: (context) => const CustomImprintPage(),
      },
    ),
  );
}
