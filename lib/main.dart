import 'package:flutter/material.dart';

import 'package:hamburg_bike_app/configuration_service.dart';
import 'package:hamburg_bike_app/theme.dart';
import 'package:trufi_core/trufi_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    TrufiApp(
      theme: stadtnaviTheme,
      bottomBarTheme: bottomBarTheme,
      configuration: setupTrufiConfiguration(),
    ),
  );
}
