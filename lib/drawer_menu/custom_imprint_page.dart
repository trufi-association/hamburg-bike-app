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
                        ? "Information according to § 5 TMG:\n\n"
                            "Trufi Association e.V.\n"
                            "Postal address:\n"
                            "Rodenbeker Str. 18c\n"
                            "22935 Hamburg\n\n"
                            "Contact details:\n"
                            "Phone: +491634791397\n"
                            "E-mail: info@trufi-association.org\n\n"
                            "Represented by:\n"
                            "Christoph Hanser (Chairman)\n"
                            "Registered at Hamburg Local Court\n"
                            "VR 24026\n\n"
                            "Information about the website\n"
                            "Information pursuant to § 36 VSBG In accordance with § 36 VSBG (Consumer Dispute Settlement Act - Act on Alternative Dispute Resolution in Consumer Matters), the operator of this website declares:\n\n"
                            "We are neither willing nor obliged to participate in dispute resolution proceedings before a consumer arbitration board.\n\n"
                        : "Angaben gemäß § 5 TMG:\n\n"
                            "Trufi Association e.V.\n"
                            "Postanschrift:\n"
                            "Rodenbeker Str. 18c\n"
                            "22935 Hamburg\n\n"
                            "Kontakt:\n"
                            "Telefon: +491634791397\n"
                            "E-Mail: info@trufi-association.org\n\n"
                            "Vertreten durch:\n"
                            "Christoph Hanser (Vorsitzender)\n"
                            "Eingetragen am Amtsgericht Hamburg\n"
                            "VR 24026\n\n"
                            "Hinweise zur Website\n"
                            "Information gemäß § 36 VSBG Gemäß § 36 VSBG (Verbraucherstreitbeilegungsgesetz – Gesetz über die alternative Streitbeilegung in Verbrauchersachen) erklärt der Betreiber dieser Website:\n\n"
                            "Wir sind weder bereit noch verpflichtet, an Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle teilzunehmen.\n\n",
                    style: textTheme,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const TrufiDrawer(CustomImprintPage.route),
    );
  }
}
