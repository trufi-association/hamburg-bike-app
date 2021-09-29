import 'package:trufi_core/blocs/configuration/configuration_cubit.dart';
import 'package:trufi_core/blocs/preferences/preferences_cubit.dart';
import 'package:trufi_core/l10n/trufi_localization.dart';
import 'package:trufi_core/models/menu/default_pages_menu.dart';
import 'package:trufi_core/models/menu/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:trufi_core/models/menu/social_media/social_media_item.dart';
import 'package:trufi_core/models/menu/social_media/facebook_social_media.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trufi_core/models/menu/social_media/twitter_social_media.dart';
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
                ? "Recommend the app"
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

class YoutubeSocialMedia extends SocialMediaItem {
  YoutubeSocialMedia(String url)
      : super(
          url: url,
          buildIcon: (context) => SvgPicture.string(
            '<svg height="682pt" viewBox="-21 -117 682.66672 682" width="682pt" xmlns="http://www.w3.org/2000/svg"><path d="m626.8125 64.035156c-7.375-27.417968-28.992188-49.03125-56.40625-56.414062-50.082031-13.703125-250.414062-13.703125-250.414062-13.703125s-200.324219 0-250.40625 13.183593c-26.886719 7.375-49.03125 29.519532-56.40625 56.933594-13.179688 50.078125-13.179688 153.933594-13.179688 153.933594s0 104.378906 13.179688 153.933594c7.382812 27.414062 28.992187 49.027344 56.410156 56.410156 50.605468 13.707031 250.410156 13.707031 250.410156 13.707031s200.324219 0 250.40625-13.183593c27.417969-7.378907 49.03125-28.992188 56.414062-56.40625 13.175782-50.082032 13.175782-153.933594 13.175782-153.933594s.527344-104.382813-13.183594-154.460938zm-370.601562 249.878906v-191.890624l166.585937 95.945312zm0 0"/></svg>',
            height: 25,
            width: 25,
            color: Colors.grey,
          ),
          name: (BuildContext context) {
            return Localizations.localeOf(context).languageCode == 'en'
                ? "Follow us on YouTube"
                : "Folge uns auf YouTube";
          },
        );
}

class LinkdInSocialMedia extends SocialMediaItem {
  LinkdInSocialMedia(String url)
      : super(
          url: url,
          buildIcon: (context) => SvgPicture.string(
            '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/></svg>',
            height: 25,
            width: 25,
            color: Colors.grey,
          ),
          name: (BuildContext context) {
            return Localizations.localeOf(context).languageCode == 'en'
                ? "Follow us on LinkdIn"
                : "Folge uns auf LinkdIn";
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
        return Localizations.localeOf(context).languageCode == 'en'
            ? "Connections"
            : localization.menuConnections;
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
        return Localizations.localeOf(context).languageCode == 'en'
            ? "Favourites"
            : localization.menuYourPlaces;
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
              YoutubeSocialMedia(
                "https://www.youtube.com/channel/UCe5cvHdDNOyVfUyy0X8-M8Q",
              ),
              FacebookSocialMedia("https://www.facebook.com/TrufiAssoc"),
              TwitterSocialMedia("https://twitter.com/TrufiAssoc"),
              LinkdInSocialMedia(
                  "https://www.linkedin.com/company/trufi-association/"),
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
            ? "Rate app"
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
