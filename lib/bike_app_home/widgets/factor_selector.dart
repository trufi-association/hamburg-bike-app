import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trufi_core/blocs/payload_data_plan/payload_data_plan_cubit.dart';
import 'package:trufi_core/models/enums/enums_plan/enums_plan.dart';

class FactorSelector extends StatelessWidget {
  const FactorSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final islanguageCodeEn =
        Localizations.localeOf(context).languageCode == "en";
    final payloadDataPlanCubit = context.read<PayloadDataPlanCubit>();
    return BlocBuilder<PayloadDataPlanCubit, PayloadDataPlanState>(
      builder: (context, state) {
        return DropdownButton<TriangleFactor>(
          hint: Container(
            height: 40,
            padding: const EdgeInsets.only(
              left: 2,
              right: 10.0,
              top: 9.0,
            ),
            child: Text(
              islanguageCodeEn
                  ? "How much Bicycle do you want?"
                  : "Wieviel Rad möchtest du?",
              style: theme.textTheme.subtitle1.copyWith(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          value: listTriangleFactor.firstWhere(
            (value) => value.name == state.triangleFactor.name,
            orElse: () => null,
          ),
          underline: Container(
            color: theme.dividerColor,
            height: 0.65,
          ),
          icon: Container(
            padding: const EdgeInsets.only(
              right: 10.0,
              // top: 9.5,
            ),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xff747474),
              size: 22,
            ),
          ),
          isExpanded: true,
          onChanged: (TriangleFactor value) {
            payloadDataPlanCubit.setTriangleFactor(value);
          },
          items: listTriangleFactor.map((TriangleFactor value) {
            return DropdownMenuItem<TriangleFactor>(
              value: value,
              child: Text(
                factorTranslateValue(value, islanguageCodeEn),
                style: theme.textTheme.subtitle1.copyWith(
                  fontSize: 18,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

  String factorTranslateValue(TriangleFactor triangleFactor, bool islanguageCodeEn) {
    String translation;
    switch (triangleFactor) {
      case TriangleFactor.lessPublicTransport:
        translation = islanguageCodeEn ? "More bike" : "Mehr Rad";
        break;
      case TriangleFactor.normal:
        translation = islanguageCodeEn ? "Bike & Public Transport" : "Rad & ÖPNV";
        break;
      case TriangleFactor.morePublicTransport:
        translation = islanguageCodeEn ? "More ÖPNV" : "Mehr ÖPNV";
        break;
      case TriangleFactor.unknown:
        translation = islanguageCodeEn ? "Bike & ÖPNV" : "Rad&ÖPNV";
    }
    return translation;
  }