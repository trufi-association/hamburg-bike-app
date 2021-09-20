import 'package:trufi_core/blocs/configuration/configuration_cubit.dart';
import 'package:trufi_core/blocs/preferences/preferences_cubit.dart';
import 'package:trufi_core/l10n/trufi_localization.dart';
import 'package:trufi_core/models/menu/default_pages_menu.dart';
import 'package:trufi_core/models/menu/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:trufi_core/models/menu/social_media/social_media_item.dart';
import 'package:trufi_core/models/menu/social_media/facebook_social_media.dart';
import 'package:trufi_core/models/menu/social_media/instagram_social_media.dart';
import 'package:trufi_core/models/menu/social_media/twitter_social_media.dart';
import 'package:trufi_core/models/menu/social_media/website_social_media.dart';
import 'package:trufi_core/pages/feedback.dart';
import 'package:trufi_core/pages/home/home_page.dart';
import 'package:trufi_core/pages/saved_places/saved_places.dart';
import 'package:trufi_core/models/menu/default_item_menu.dart';
import 'package:app_review/app_review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trufi_core/widgets/trufi_drawer.dart';

import 'custom_about_page.dart';
import 'custom_imprint_page.dart';

class IHrStart extends MenuItem {
  IHrStart()
      : super(
          selectedIcon: (context) => Container(),
          notSelectedIcon: (context) => Container(),
          name: (context) => MenuItem.buildName(
            context,
            "Ihr Start",
          ),
          onClick: (context, _) {},
        );
}

class CustomAppShareButtonMenu extends MenuItem {
  CustomAppShareButtonMenu()
      : super(
          selectedIcon: (context) =>
              const Icon(Icons.verified, color: Colors.grey),
          notSelectedIcon: (context) =>
              const Icon(Icons.verified, color: Colors.grey),
          name: (context) => MenuItem.buildName(
            context,
            Localizations.localeOf(context).languageCode == 'en'
                ? "Share the app"
                : "App weiterempfehlen",
          ),
          onClick: (context, _) {
            // TODO implement share app
            // final currentLocale = Localizations.localeOf(context).languageCode;
            // Share.share(currentLocale == "en"
            //     ? """
            // Download the stadtnavi app, the public transport app for Herrenberg and its surroundings on https://herrenberg.stadtnavi.de/
            // """
            //     : """
            // Hol' dir die stadtnavi App für den öffentlichen Nahverkehr in Herrenberg und Umgebung auf https://herrenberg.stadtnavi.de/
            // """);
          },
        );
}

class AboutButtonMenu extends MenuItem {
  AboutButtonMenu()
      : super(
          id: CustomAboutPage.route,
          selectedIcon: (context) => const Icon(
            Icons.groups,
            color: Colors.black,
          ),
          notSelectedIcon: (context) => const Icon(
            Icons.groups,
            color: Colors.grey,
          ),
          name: (context) => MenuItem.buildName(
            context,
            Localizations.localeOf(context).languageCode == 'en'
                ? "About us"
                : "Über Uns",
          ),
          onClick: (context, isSelected) {
            Navigator.popUntil(
                context, ModalRoute.withName(CustomAboutPage.route));
            if (!isSelected) {
              Navigator.pushNamed(context, CustomAboutPage.route);
            }
          },
        );
}

class ImprintButtonMenu extends MenuItem {
  ImprintButtonMenu()
      : super(
          id: CustomImprintPage.route,
          selectedIcon: (context) => const Icon(
            Icons.receipt_rounded,
            color: Colors.black,
          ),
          notSelectedIcon: (context) => const Icon(
            Icons.receipt_rounded,
            color: Colors.grey,
          ),
          name: (context) => MenuItem.buildName(
            context,
            Localizations.localeOf(context).languageCode == 'en'
                ? "Imprint"
                : "Impressum",
          ),
          onClick: (context, isSelected) {
            Navigator.popUntil(
                context, ModalRoute.withName(CustomImprintPage.route));
            if (!isSelected) {
              Navigator.pushNamed(context, CustomImprintPage.route);
            }
          },
        );
}

final List<List<MenuItem>> menuItems = [
  [
    MenuPageItem(
      id: HomePage.route,
      selectedIcon: (context) => const Icon(
        Icons.location_on_sharp,
        color: Colors.black,
      ),
      notSelectedIcon: (context) => const Icon(
        Icons.location_on_sharp,
        color: Colors.grey,
      ),
      name: (context) {
        final localization = TrufiLocalization.of(context);
        return localization.menuConnections;
      },
    ),
    MenuPageItem(
      id: SavedPlacesPage.route,
      selectedIcon: (context) => const Icon(
        Icons.star_border,
        color: Colors.black,
      ),
      notSelectedIcon: (context) => const Icon(
        Icons.star_border,
        color: Colors.grey,
      ),
      name: (context) {
        final localization = TrufiLocalization.of(context);
        return localization.menuYourPlaces;
      },
    )
  ],
  [
    MenuPageItem(
      id: FeedbackPage.route,
      selectedIcon: (context) => const Icon(
        Icons.question_answer,
        color: Colors.black,
      ),
      notSelectedIcon: (context) => const Icon(
        Icons.question_answer,
        color: Colors.grey,
      ),
      name: (context) => Localizations.localeOf(context).languageCode == "en"
          ? "Feedback on the app"
          : "Feedback zur App",
    ),
    AboutButtonMenu(),
    SimpleMenuItem(
        buildIcon: (context) => const Icon(Icons.share),
        name: (context) {
          final theme = Theme.of(context);
          return DropdownButton<SocialMediaItem>(
            icon: Row(
              children: [
                Text(Localizations.localeOf(context).languageCode == "en"
                    ? "Social media"
                    : "Soziale Medien"),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
            selectedItemBuilder: (_) => [],
            underline: Container(),
            style: theme.textTheme.bodyText1,
            onChanged: (SocialMediaItem value) {
              value.onClick(context, true);
            },
            items: <SocialMediaItem>[
              // TODO use hamburgo bike app links
              FacebookSocialMedia("https://www.facebook.com/trufiapp"),
              InstagramSocialMedia("https://www.instagram.com/trufi.app"),
              TwitterSocialMedia("https://twitter.com/TrufiAssoc"),
              WebSiteSocialMedia("https://www.trufi.app/blog/"),
            ].map((SocialMediaItem value) {
              return DropdownMenuItem<SocialMediaItem>(
                value: value,
                child: Row(
                  children: [
                    value.notSelectedIcon(context),
                    value.name(context),
                  ],
                ),
              );
            }).toList(),
          );
        }),
    SimpleMenuItem(
      buildIcon: (context) => const Icon(
        Icons.thumb_up_alt,
        color: Colors.grey,
      ),
      name: (context) => MenuItem.buildName(
        context,
        Localizations.localeOf(context).languageCode == "en"
            ? "Rate the app"
            : "App bewerten",
      ),
      onClick: () {
        AppReview.writeReview;
      },
    ),
    CustomAppShareButtonMenu(),
  ],
  [
    SimpleMenuItem(
        buildIcon: (context) => const Icon(Icons.translate),
        name: (context) {
          final values = context
              .read<ConfigurationCubit>()
              .state
              .supportedLanguages
              .map((lang) =>
                  LanguageDropdownValue(lang.languageCode, lang.displayName))
              .toList();
          final theme = Theme.of(context);
          final languageCode = Localizations.localeOf(context).languageCode;
          return DropdownButton<LanguageDropdownValue>(
            style: theme.textTheme.bodyText1,
            value: values
                .firstWhere((value) => value.languageCode == languageCode),
            onChanged: (LanguageDropdownValue value) {
              BlocProvider.of<PreferencesCubit>(context)
                  .updateLanguage(value.languageCode);
            },
            underline: Container(),
            items: values.map((LanguageDropdownValue value) {
              return DropdownMenuItem<LanguageDropdownValue>(
                value: value,
                child: Text(
                  value.languageString,
                  style: theme.textTheme.bodyText1,
                ),
              );
            }).toList(),
          );
        }),
    ImprintButtonMenu()
  ],
];
