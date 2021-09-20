import 'package:flutter/material.dart';
import 'package:trufi_core/widgets/trufi_drawer.dart';

class CustomImprintPage extends StatefulWidget {
  static const String route = "/custom-imprint";
  const CustomImprintPage({Key key}) : super(key: key);

  @override
  _CustomImprintPageState createState() => _CustomImprintPageState();
}

class _CustomImprintPageState extends State<CustomImprintPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final spacer = SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnglish = Localizations.localeOf(context).languageCode == "en";
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
                  height: 250,
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
                  isEnglish ? "Imprint" : "Impressum",
                  style: theme.textTheme.bodyText2.copyWith(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 24),
                Text(
                  isEnglish
                      // TODO translate german
                      ? "Angaben gemäß § 5 TMG:"
                      : "Angaben gemäß § 5 TMG:",
                  style: textTheme,
                ),
                spacer,
                Text(
                  isEnglish
                      // TODO translate german
                      ? "Trufi Association e.V.\nPostanschrift:"
                      : "Trufi Association e.V.\nPostanschrift:",
                  style: textTheme,
                ),
                SizedBox(height: 10),
                Text(
                  isEnglish
                      // TODO translate german
                      ? "Rodenbeker Str. 18c\n22935 Hamburg"
                      : "Rodenbeker Str. 18c\n22935 Hamburg",
                  style: textTheme,
                ),
                spacer,
                Text(
                  isEnglish
                      // TODO translate german
                      ? "Kontakt:\nTelefon: +491634791397\nE-Mail: info@trufi-association.org"
                      : "Kontakt:\nTelefon: +491634791397\nE-Mail: info@trufi-association.org",
                  style: textTheme,
                ),
                spacer,
                Text(
                  isEnglish
                      // TODO translate german
                      ? "Vertreten durch:\nChristoph Hanser (Vorsitzender)\nEingetragen am Amtsgericht Hamburg\nVR 24026"
                      : "Vertreten durch:\nChristoph Hanser (Vorsitzender)\nEingetragen am Amtsgericht Hamburg\nVR 24026",
                  style: textTheme,
                ),
                spacer,
                Text(
                  isEnglish
                      // TODO translate german
                      ? "Hinweise zur Website\nInformation gemäß § 36 VSBG, Gemäß § 36 VSBG (Verbraucherstreitbeilegungsgesetz – Gesetz über die alternative Streitbeilegung in Verbrauchersachen) erklärt der Betreiber dieser Website:"
                      : "Hinweise zur Website\nInformation gemäß § 36 VSBG, Gemäß § 36 VSBG (Verbraucherstreitbeilegungsgesetz – Gesetz über die alternative Streitbeilegung in Verbrauchersachen) erklärt der Betreiber dieser Website:",
                  style: textTheme,
                ),
                spacer,
                Text(
                  isEnglish
                      // TODO translate german
                      ? "Wir sind weder bereit noch verpflichtet, an Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle teilzunehmen."
                      : "Wir sind weder bereit noch verpflichtet, an Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle teilzunehmen.",
                  style: textTheme,
                ),
                spacer,
              ],
            ),
          ),
        ],
      ),
      drawer: const TrufiDrawer(CustomImprintPage.route),
    );
  }
}
