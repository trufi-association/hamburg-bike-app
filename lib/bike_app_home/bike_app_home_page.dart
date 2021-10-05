import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamburg_bike_app/bike_app_home/widgets/dialog_confirm_location.dart';
import 'package:trufi_core/blocs/app_review_cubit.dart';
import 'package:trufi_core/blocs/configuration/configuration_cubit.dart';
import 'package:trufi_core/blocs/home_page_cubit.dart';
import 'package:trufi_core/blocs/payload_data_plan/payload_data_plan_cubit.dart';
import 'package:trufi_core/blocs/preferences/preferences_cubit.dart';
import 'package:trufi_core/blocs/search_locations/search_locations_cubit.dart';
import 'package:trufi_core/keys.dart' as keys;
import 'package:trufi_core/l10n/trufi_localization.dart';
import 'package:trufi_core/models/map_route_state.dart';
import 'package:trufi_core/models/trufi_place.dart';
import 'package:trufi_core/pages/choose_location.dart';
import 'package:trufi_core/pages/home/plan_map/widget/custom_text_button.dart';
import 'package:trufi_core/widgets/fetch_error_handler.dart';
import 'package:trufi_core/widgets/trufi_drawer.dart';

import 'results_screen.dart';
import 'widgets/ba_form_field_landscape.dart';
import 'widgets/ba_form_field_portrait.dart';
import 'widgets/date_time_picker/date_selector.dart';
import 'widgets/factor_selector.dart';
import 'widgets/location_icon.dart';

class BikeAppHomePage extends StatefulWidget {
  static const String route = '/';
  const BikeAppHomePage({Key key}) : super(key: key);

  @override
  _BikeAppHomePageState createState() => _BikeAppHomePageState();
}

class _BikeAppHomePageState extends State<BikeAppHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedRadio = 0;
  double rating = 0;
  bool firstScreen = true;
  bool wasValidateForm = false;

  void setSelectedRadio(int value) {
    setState(() {
      selectedRadio = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final homePageCubit = context.watch<HomePageCubit>();
    final payloadDataPlanCubit = context.read<PayloadDataPlanCubit>();
    final homePageState = homePageCubit.state;
    final config = context.read<ConfigurationCubit>().state;
    final islanguageCodeEn =
        Localizations.localeOf(context).languageCode == "en";
    return BlocListener<HomePageCubit, MapRouteState>(
      listener: (context, state) {
        final hasPlan = state.plan != null && state.plan.error == null;
        if (hasPlan) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ResultsScreen(plan: state.plan),
            ),
          );
        }
      },
      listenWhen: (oldState, newState) {
        return oldState.plan == null;
      },
      child: Scaffold(
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
                          islanguageCodeEn
                              ? "Not Without My Bike"
                              : "Nicht ohne mein Rad",
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
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/background-image.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                  ),
                ],
              ),
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                children: [
                  const SizedBox(height: 30),
                  Text(
                    islanguageCodeEn ? "Moin!" : "Moin!",
                    style: theme.textTheme.bodyText2.copyWith(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (isPortrait)
                    BAFormFieldsPortrait(
                      spaceBetween: 20,
                      onSaveFrom: (TrufiLocation fromPlace) =>
                          homePageCubit.setFromPlace(fromPlace),
                      onSaveTo: (TrufiLocation fromPlace) =>
                          homePageCubit.setToPlace(fromPlace),
                      onSwap: () => homePageCubit.swapLocations(),
                      onReset: () async {
                        await homePageCubit.reset();
                        await payloadDataPlanCubit.resetDataDate();
                      },
                      isValidateForm: wasValidateForm,
                    )
                  else
                    BAFormFieldsLandscape(
                      onSaveFrom: (TrufiLocation fromPlace) =>
                          homePageCubit.setFromPlace(fromPlace),
                      onSaveTo: (TrufiLocation fromPlace) =>
                          homePageCubit.setToPlace(fromPlace),
                      onSwap: () => homePageCubit.swapLocations(),
                      onReset: () async {
                        await homePageCubit.reset();
                        await payloadDataPlanCubit.resetDataDate();
                      },
                    ),
                  const SizedBox(height: 30),
                  DateSelector(
                    color: const Color(0xff747474),
                    onFetchPlan: () {},
                  ),
                  const SizedBox(height: 35),
                  const FactorSelector(),
                  const SizedBox(height: 40),
                  Text(
                    islanguageCodeEn ? "Favourites" : "Favoriten",
                    style: theme.textTheme.subtitle1.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: 65,
                    child: Row(
                      children: [
                        Flexible(
                          child: BlocBuilder<SearchLocationsCubit,
                              SearchLocationsState>(
                            builder: (contextBuilder, state) {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    children: [
                                      ...state.myDefaultPlaces
                                          .map(
                                            (place) => LocationIcon(
                                              location: place,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                            ),
                                          )
                                          .toList(),
                                      ...state.myPlaces
                                          .map(
                                            (place) => LocationIcon(
                                              location: place,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                            ),
                                          )
                                          .toList(),
                                      Container(
                                        height: 48,
                                        width: 48,
                                        margin: const EdgeInsets.only(left: 8),
                                        child: InkWell(
                                          onTap: () {
                                            _addNewPlace();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: SizedBox(
                      child: CustomTextButton(
                        text: islanguageCodeEn ? "SHOW RESULTS" : "SUCHEN",
                        onPressed: () {
                          setState(() {
                            wasValidateForm = true;
                          });
                          _callFetchPlan(context);
                        },
                        color: theme.accentColor,
                        textStyle: theme.textTheme.headline6.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        borderRadius: 5,
                        height: 50,
                        width: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
              if (config.animations.loading != null && homePageState.isFetching)
                Positioned.fill(
                    child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ))
            ],
          ),
        ),
        drawer: const TrufiDrawer(keys.homePage),
      ),
    );
  }

  Future<void> _addNewPlace() async {
    final searchLocationsCubit = context.read<SearchLocationsCubit>();
    final ChooseLocationDetail chooseLocationDetail =
        await ChooseLocationPage.selectPosition(
      context,
    );
    if (chooseLocationDetail == null) return;
    final dafaultLocation = TrufiLocation(
      description: chooseLocationDetail.description,
      address: chooseLocationDetail.street,
      latitude: chooseLocationDetail.location.latitude,
      longitude: chooseLocationDetail.location.longitude,
      type: 'saved_place:map',
    );

    final TrufiLocation newLocation = await showDialog<TrufiLocation>(
        context: context,
        builder: (BuildContext context) {
          return DialogConfirmLocation(location: dafaultLocation);
        });
    if (newLocation != null) searchLocationsCubit.insertMyPlace(newLocation);
  }

  Future<void> _callFetchPlan(BuildContext context) async {
    final TrufiLocalization localization = TrufiLocalization.of(context);
    final homePageCubit = context.read<HomePageCubit>();
    final appReviewCubit = context.read<AppReviewCubit>();
    final correlationId = context.read<PreferencesCubit>().state.correlationId;
    final payloadDataPlanCubit = context.read<PayloadDataPlanCubit>();
    await homePageCubit
        .fetchPlan(correlationId, localization,
            advancedOptions: payloadDataPlanCubit.state)
        .then((value) => appReviewCubit.incrementReviewWorthyActions())
        .catchError((error) => onFetchError(context, error as Exception));
  }
}
