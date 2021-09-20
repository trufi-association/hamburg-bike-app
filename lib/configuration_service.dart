import 'package:flutter/material.dart';
import 'package:hamburg_bike_app/map_configuration/custom_marker_configuration.dart';
import 'package:latlong2/latlong.dart';
import 'package:trufi_core/blocs/configuration/configuration.dart';
import 'package:trufi_core/blocs/configuration/models/animation_configuration.dart';
import 'package:trufi_core/blocs/configuration/models/attribution.dart';
import 'package:trufi_core/blocs/configuration/models/language_configuration.dart';
import 'package:trufi_core/blocs/configuration/models/map_configuration.dart';
import 'package:trufi_core/blocs/configuration/models/url_collection.dart';
import 'package:trufi_core/models/definition_feedback.dart';
import 'package:trufi_core/models/enums/server_type.dart';

import 'map_configuration/custom_itinerary_creator.dart';

Configuration setupTrufiConfiguration() {
  // Attribution
  final attribution = Attribution(
    representatives: [
      "Christoph Hanser",
      "Samuel Rioja",
    ],
    team: [
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
    ],
    translators: [
      "Gladys Aguilar",
      "Jeremy Maes",
      "Gaia Vitali Roscini",
    ],
    routes: [
      "Trufi team",
      "Guia Cochala team",
    ],
    openStreetMap: [
      "Marco Antonio",
      "Noémie",
      "Philipp",
      "Felix D",
      "Valor Naram",
    ],
  );

  // Urls
  final urls = UrlCollection(
    openTripPlannerUrl:
        "https://api.trufi.app/otp-hh/routers/default/index/graphql",
  );

  // Map
  final map = MapConfiguration(
    defaultZoom: 13.0,
    onlineMaxZoom: 18,
    center: LatLng(53.551086, 9.993682),
    southWest: LatLng(53.331927, 9.604565),
    northEast: LatLng(53.767577, 10.322638),
    markersConfiguration: const CustomMarkerConfiguration(),
    itinararyCreator: const CustomItineraryCreator(),
  );

  // Languages
  final languages = [
    LanguageConfiguration("de", "DE", "Deutsch", isDefault: true),
    LanguageConfiguration("en", "US", "English")
  ];

  final customTranslations = TrufiCustomLocalizations()
    ..title = {
      const Locale("de"): "Nicht ohne mein Rad",
      const Locale("en"): "Not without my bike"
    }
    ..tagline = {const Locale("de"): "Hamburg", const Locale("en"): "Hamburg"};

  return Configuration(
    customTranslations: customTranslations,
    supportedLanguages: languages,
    animations: AnimationConfiguration(),
    feedbackDefinition: FeedbackDefinition(
      FeedBackType.email,
      "info@trufi-association.org",
    ),
    serverType: ServerType.graphQLServer,
    teamInformationEmail: "info@trufi-association.org",
    attribution: attribution,
    map: map,
    urls: urls,
  );
}
