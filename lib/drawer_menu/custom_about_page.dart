import 'package:flutter/material.dart';
import 'package:trufi_core/widgets/trufi_drawer.dart';

class CustomAboutPage extends StatefulWidget {
  static const String route = "/custom-about";
  const CustomAboutPage({Key key}) : super(key: key);

  @override
  _CustomAboutPageState createState() => _CustomAboutPageState();
}

class _CustomAboutPageState extends State<CustomAboutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme =
        theme.textTheme.subtitle1.copyWith(fontSize: 13, height: 1.5);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          elevation: 0,
          toolbarHeight: 120,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    icon: const Icon(
                      Icons.menu_outlined,
                      size: 45,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  "Nicht ohne mein Rad",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/background-image.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 2,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              children: [
                const SizedBox(height: 40),
                Text(
                  Localizations.localeOf(context).languageCode == "en"
                      ? "About Us"
                      : "Über Uns",
                  style: theme.textTheme.bodyText2.copyWith(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  Localizations.localeOf(context).languageCode == "en"
                      ? "We are the coolest group ever! Any other questions?"
                      : "Wir sind eine echt coole Truppe. Noch Fragen?",
                  style: theme.textTheme.subtitle1.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  Localizations.localeOf(context).languageCode == "en"
                      ? "Dear Bike and Public Transport User!\n\n"
                          "Nicht ohne mein Rad unites bicycle and public transport"
                          " journeys in Hamburg, making life easier for people"
                          " who use bikes as their main means of transport. "
                          " Defy long trips and rainy days by using public "
                          " transport without abandoning your bike! ITS World Congress "
                          " and the Hamburg Transport Association (HVV) chose "
                          " Trufi Association to create a first-of-its-kind bike app, "
                          " and voilà, here it is: Nicht ohne mein Rad!\n\n"
                          "Trufi Association is an international NGO that promotes"
                          "easier access to public transport. Official maps, apps,"
                          "and schedules don’t provide all the routes, or they"
                          "simply don’t exist in many cities. We fill in the"
                          "gaps – and sometimes even map the routes from scratch."
                          "Our apps help everyone find the best way to get from "
                          "Point A to Point B within their cities. Well-designed "
                          "mobility contributes to greater sustainability, cleaner"
                          "air and better quality of life."
                      : "Lieber Fahrrad- und ÖPNV-Nutzer!\n\n"
                          "Nicht ohne mein Rad vereint Fahrrad und ÖPNV in "
                          "Hamburg und macht das Leben für Menschen, "
                          "die das Fahrrad als Hauptverkehrsmittel nutzen, "
                          "einfacher. In Zukunft kannst du langen Wegen oder "
                          "Regentagen mit der Nutzung der ÖPNV die Stirn "
                          "bieten ohne auf dein Rad zu verzichten. Deshalb "
                          "haben wir von Trufi Association im Auftrag der ITS "
                          "und der HVV Nägel mit Köpfen gemacht und voilà: "
                          "Hier ist sie die Nicht ohne mein Rad!\n\n"
                          "Trufi Association ist eine internationale NGO, "
                          "die sich für einen leichteren Zugang zu öffentlichen "
                          "Verkehrsmitteln einsetzt. Offizielle Karten, Apps "
                          "und Fahrpläne enthalten oft nicht alle Routen. In "
                          "vielen Städten dieser Welt gibt es sogar gar keine "
                          "Fahrpläne. Wir füllen Lücken oder zeichnen Routen "
                          "von Grund auf neu auf. Unsere Apps helfen jedem, den "
                          "besten Weg zu finden, um in seiner Stadt von A nach B "
                          "zu kommen. Gut durchdachte Mobilität trägt zu mehr "
                          "Nachhaltigkeit, sauberer Luft und mehr Lebensqualität bei.",
                  style: textTheme,
                ),
                const SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    'assets/custom_images/about-us.png',
                    fit: BoxFit.fill,
                    width: 250,
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    'assets/custom_images/trufi-logo.png',
                    fit: BoxFit.fill,
                    width: 175,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
      drawer: const TrufiDrawer(CustomAboutPage.route),
    );
  }
}
