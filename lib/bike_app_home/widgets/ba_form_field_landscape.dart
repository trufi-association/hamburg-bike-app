import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trufi_core/blocs/configuration/configuration_cubit.dart';
import 'package:trufi_core/blocs/home_page_cubit.dart';
import 'package:trufi_core/models/trufi_place.dart';

import 'custom_buttons.dart';
import 'default_location_form_field.dart';

class BAFormFieldsLandscape extends StatelessWidget {
  const BAFormFieldsLandscape({
    Key key,
    @required this.onSaveFrom,
    @required this.onSaveTo,
    @required this.onSwap,
    @required this.onReset,
  }) : super(key: key);

  final void Function(TrufiLocation) onSaveFrom;
  final void Function(TrufiLocation) onSaveTo;
  final void Function() onSwap;
  final void Function() onReset;

  @override
  Widget build(BuildContext context) {
    final homePageCubit = context.read<HomePageCubit>();
    final homePageState = homePageCubit.state;
    final cfg = context.read<ConfigurationCubit>().state;
    final islanguageCodeEn =
        Localizations.localeOf(context).languageCode == "en";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: DefaultLocationFormField(
            isOrigin: true,
            hintText: islanguageCodeEn ? "Your start" : "Dein Start",
            textLeadingImage: cfg.map.markersConfiguration.fromMarker,
            onSaved: onSaveFrom,
            value: homePageState.fromPlace,
          ),
        ),
        if (homePageState.toPlace != null && homePageState.fromPlace != null)
          Padding(
            padding: const EdgeInsets.only(top: 17),
            child: SwapButton(
              orientation: Orientation.landscape,
              onSwap: onSwap,
            ),
          )
        else
          const SizedBox(
            width: 48.0,
          ),
        Flexible(
          child: DefaultLocationFormField(
            isOrigin: false,
            hintText: islanguageCodeEn ? "Your destination" : "Dein Ziel",
            textLeadingImage: cfg.map.markersConfiguration.toMarker,
            onSaved: onSaveTo,
            value: homePageState.toPlace,
          ),
        ),
        if (homePageState.toPlace != null && homePageState.fromPlace != null)
          Padding(
            padding: const EdgeInsets.only(top: 17),
            child: ResetButton(
              onReset: onReset,
            ),
          )
      ],
    );
  }
}
