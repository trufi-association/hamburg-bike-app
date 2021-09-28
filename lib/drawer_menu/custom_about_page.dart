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
        theme.textTheme.subtitle1.copyWith(fontSize: 16, height: 1.5);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final isEnglish = Localizations.localeOf(context).languageCode == "en";
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Nicht ohne mein Rad",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          "Hamburg",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    isEnglish ? "About Us" : "Über Uns",
                    style: theme.textTheme.bodyText2.copyWith(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(1, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: ExpansionTile(
                          title: Text(
                            isEnglish
                                ? "We are the coolest group ever! Any other questions?"
                                : "Wir sind eine echt coole Truppe. Noch Fragen?",
                            style: textTheme,
                          ),
                          children: [
                            RichText(
                              text:
                                  TextSpan(style: textTheme, children: <TextSpan>[
                                TextSpan(
                                  text: isEnglish
                                      ? "Dear Bike and Public Transport User!\n\n"
                                      : "Lieber Fahrrad- und ÖPNV-Nutzer!\n\n",
                                ),
                                TextSpan(
                                  text: "Nicht ohne mein Rad",
                                  style: textTheme.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: isEnglish
                                      ? " unites bicycle and public transport"
                                          " journeys in Hamburg, making life easier for people"
                                          " who use bikes as their main means of transport. "
                                          " Defy long trips and rainy days by using public "
                                          " transport without abandoning your bike! ITS World Congress "
                                          " and the Hamburg Transport Association (HVV) chose "
                                          " Trufi Association to create a first-of-its-kind bike app, "
                                          " and voilà, here it is: "
                                      : " vereint Fahrrad und ÖPNV in "
                                          "Hamburg und macht das Leben für Menschen, "
                                          "die das Fahrrad als Hauptverkehrsmittel nutzen, "
                                          "einfacher. In Zukunft kannst du langen Wegen oder "
                                          "Regentagen mit der Nutzung der ÖPNV die Stirn "
                                          "bieten ohne auf dein Rad zu verzichten. Deshalb "
                                          "haben wir von Trufi Association im Auftrag der ITS "
                                          "und der HVV Nägel mit Köpfen gemacht und voilà: "
                                          "Hier ist sie die ",
                                ),
                                TextSpan(
                                  text: isEnglish
                                      ? "Nicht ohne mein Rad."
                                      : "„Nicht ohne mein Rad App“",
                                  style: textTheme.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: isEnglish
                                      ? "!\n\nTrufi Association is an international NGO that promotes"
                                          "easier access to public transport. Official maps, apps,"
                                          "and schedules don’t provide all the routes, or they"
                                          "simply don’t exist in many cities. We fill in the"
                                          "gaps – and sometimes even map the routes from scratch."
                                          "Our apps help everyone find the best way to get from "
                                          "Point A to Point B within their cities. Well-designed "
                                          "mobility contributes to greater sustainability, cleaner"
                                          "air and better quality of life.\n"
                                      : "\n\nTrufi Association ist eine internationale NGO, "
                                          "die sich für einen leichteren Zugang zu öffentlichen "
                                          "Verkehrsmitteln einsetzt. Offizielle Karten, Apps "
                                          "und Fahrpläne enthalten oft nicht alle Routen. In "
                                          "vielen Städten dieser Welt gibt es sogar gar keine "
                                          "Fahrpläne. Wir füllen Lücken oder zeichnen Routen "
                                          "von Grund auf neu auf. Unsere Apps helfen jedem, den "
                                          "besten Weg zu finden, um in seiner Stadt von A nach B "
                                          "zu kommen. Gut durchdachte Mobilität trägt zu mehr "
                                          "Nachhaltigkeit, sauberer Luft und mehr Lebensqualität bei.\n",
                                ),
                              ]),
                            ),
                          ],
                          backgroundColor: Colors.white,
                          collapsedBackgroundColor: Colors.white,
                          collapsedIconColor: theme.textTheme.subtitle1.color,
                          iconColor: theme.textTheme.subtitle1.color,
                          tilePadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          childrenPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Image.asset(
                            'assets/custom_images/about-us.png',
                            fit: BoxFit.fill,
                            width: isPortrait ? null : 200,
                          ),
                        ),
                        SizedBox(width: isPortrait ? 20 : 60),
                        Flexible(
                          child: Image.asset(
                            'assets/custom_images/logo-hvv.png',
                            fit: BoxFit.fill,
                            width: isPortrait ? null : 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: Image.asset(
                      'assets/custom_images/trufi-logo.png',
                      fit: BoxFit.fill,
                      width: 115,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const TrufiDrawer(CustomAboutPage.route),
    );
  }
}
