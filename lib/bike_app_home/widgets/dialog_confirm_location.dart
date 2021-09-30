import 'package:flutter/material.dart';

import 'package:trufi_core/l10n/trufi_localization.dart';
import 'package:trufi_core/models/trufi_place.dart';
import 'package:trufi_core/pages/saved_places/dialog_edit_location.dart';

class DialogConfirmLocation extends StatefulWidget {
  final TrufiLocation location;

  const DialogConfirmLocation({
    Key key,
    @required this.location,
  }) : super(key: key);

  @override
  _DialogConfirmLocationState createState() => _DialogConfirmLocationState();
}

class _DialogConfirmLocationState extends State<DialogConfirmLocation> {
  final _formKey = GlobalKey<FormFieldState>();
  TrufiLocation location;

  @override
  void initState() {
    location = widget.location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = TrufiLocalization.of(context);
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text(
            localization.localeName == 'de'
                ? "Bestätigen Sie die Erstellung eines neuen Ortes"
                : "Confirm the creation of a new place",
            style: theme.textTheme.bodyText1.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
          buttonPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  // TODO translation
                  "Name",
                  style: theme.textTheme.subtitle1,
                ),
                TextFormField(
                  key: _formKey,
                  initialValue: location.displayName(localization),
                  decoration: InputDecoration(
                    hintText: localization.savedPlacesEnterNameTitle,
                    hintStyle: theme.textTheme.subtitle1,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                  onChanged: (value) {
                    location = location.copyWith(description: value);
                  },
                  validator: (value) => _validateInput(value, localization),
                  autocorrect: false,
                ),
                const SizedBox(height: 15),
                Text(
                  "Icon",
                  style: theme.textTheme.subtitle1,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: GridView.builder(
                    itemCount: listIconsPlace.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (BuildContext builderContext, int index) {
                      final isSelected =
                          location.type == listIconsPlace.keys.elementAt(index);
                      return InkWell(
                        onTap: () {
                          setState(() {
                            location = location.copyWith(
                                type: listIconsPlace.keys.elementAt(index));
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            listIconsPlace.values.elementAt(index),
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(height: 0),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                onPrimary: theme.primaryColor,
              ),
              child: Text(
                localization.commonCancel.toUpperCase(),
                style: TextStyle(color: theme.primaryColor),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.of(context).pop(location);
                }
              },
              style: ElevatedButton.styleFrom(
                onPrimary: theme.primaryColor,
              ),
              child: Text(
                localization.localeName == 'de' ? "BESTÄTIGEN SIE" : "CONFIRM",
                style: TextStyle(color: theme.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validateInput(String text, TrufiLocalization localization) {
    String result;
    if (text.isEmpty) {
      result = localization.localeName == 'de'
          ? "Der Name darf nicht leer sein"
          : "The name cannot be empty";
    }
    return result;
  }
}
