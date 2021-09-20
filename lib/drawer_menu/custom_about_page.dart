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
                      // TODO translate german
                      ? "We are the coolest group ever, any other questions?"
                      : "We are the coolest group ever, any other questions?",
                  style: theme.textTheme.subtitle1.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 55),
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
