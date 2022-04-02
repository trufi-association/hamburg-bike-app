import 'dart:async';
import 'package:meta/meta.dart';

import 'package:gql/language.dart';
import 'package:graphql/client.dart';
import 'package:trufi_core/blocs/payload_data_plan/payload_data_plan_cubit.dart';
import 'package:trufi_core/models/enums/enums_plan/enums_plan.dart';
import 'package:trufi_core/models/trufi_place.dart';
import 'package:trufi_core/services/models_otp/plan.dart';
import 'package:trufi_core/services/plan_request/online_graphql_repository/graphql_client/graphql_client.dart';
import 'package:trufi_core/services/plan_request/online_graphql_repository/graphql_client/graphql_utils.dart';
import 'package:trufi_core/services/plan_request/online_graphql_repository/graphql_operation/query_utils.dart';

import 'graphql_operation/fragments/bike_plan_fragments.dart' as bike_fragment;
import 'graphql_operation/queries/bike_plan_queries.dart' as bike_query;

class GraphqlBikePlanRepository {
  final GraphQLClient client;

  GraphqlBikePlanRepository(String endpoint) : client = getClient(endpoint);

  Future<Plan> fetchPlanSimple({
    @required TrufiLocation fromLocation,
    @required TrufiLocation toLocation,
    @required List<TransportMode> transportsMode,
  }) async {
    final QueryOptions planSimpleQuery = QueryOptions(
      document: parseString(bike_query.queryBikeSimple),
      variables: <String, dynamic>{
        'fromPlace': parsePlace(fromLocation),
        'toPlace': parsePlace(toLocation),
        'numItineraries': 5,
        'transportModes': parseTransportModes(transportsMode),
      },
      fetchPolicy: FetchPolicy.networkOnly,
    );
    final planSimpleData = await client.query(planSimpleQuery);
    if (planSimpleData.hasException && planSimpleData.data == null) {
      throw planSimpleData.exception.graphqlErrors.isNotEmpty
          ? Exception("Bad request")
          : Exception("Internet no connection");
    }
    final planData =
        Plan.fromMap(planSimpleData.data['plan'] as Map<String, dynamic>);
    return planData;
  }

  Future<Plan> fetchPlanAdvanced({
    @required TrufiLocation fromLocation,
    @required TrufiLocation toLocation,
    @required PayloadDataPlanState advancedOptions,
    @required String locale,
    bool defaultFetch = false,
  }) async {
    final dateNow = DateTime.now();
    final date = advancedOptions?.date ?? dateNow;

    final QueryOptions planAdvancedQuery = QueryOptions(
      document: addFragments(parseString(bike_query.queryBikePublicTransport), [
        addFragments(bike_fragment.bikePublicTransportFragment, [
          bike_fragment.summaryPlanContainerPlanFragment,
          bike_fragment.itineraryTabPlanFragment,
          addFragments(bike_fragment.itineraryTabItineraryFragment,
              [bike_fragment.legAgencyInfoFragment]),
          addFragments(bike_fragment.summaryPlanContainerItinerariesFragment, [
            bike_fragment.itinerarySummaryListFragment,
            bike_fragment.itineraryLineLegsFragment,
            addFragments(bike_fragment.routeLinePatternFragment,
                [bike_fragment.stopCardStopFragment]),
          ]),
          bike_fragment.itineraryLineLegsFragment,
          addFragments(bike_fragment.routeLinePatternFragment, [
            bike_fragment.stopCardStopFragment,
          ]),
        ]),
        bike_fragment.bikeServiceTimeRangeFragment,
      ]),
      variables: <String, dynamic>{
        'fromPlace': parsePlace(fromLocation),
        'toPlace': parsePlace(toLocation),
        'date': parseDateFormat(date),
        'time': parseTime(date),
        'maxWalkDistance': 4828.032,
        'numItineraries': 4,
        'bikeAndPublicModes': offTimes(date),
        'searchWindow':
            advancedOptions.triangleFactor == TriangleFactor.lessPublicTransport
                ? 578
                : null,
        'optimize': advancedOptions.triangleFactor ==
                    TriangleFactor.lessPublicTransport ||
                advancedOptions.triangleFactor ==
                    TriangleFactor.morePublicTransport
            ? 'TRIANGLE'
            : null,
        'triangle': advancedOptions.triangleFactor.customValue,
        'locale': locale ?? 'de',
        'arriveBy': advancedOptions.arriveBy,
      },
    );
    final planAdvancedData = await client.query(planAdvancedQuery);
    // Exception while fetching data (/viewer/plan) : org.opentripplanner.api.common.ParameterException
    if (planAdvancedData.hasException && planAdvancedData.data == null) {
      throw planAdvancedData.exception.graphqlErrors.isNotEmpty
          ? Exception("Bad request")
          : Exception("Connection error");
    }
    if (planAdvancedData.source.isEager) {
      await Future.delayed(const Duration(milliseconds: 200));
    }
    final planData = Plan.fromMap(
        planAdvancedData.data['viewer']['plan'] as Map<String, dynamic>);
    return planData;
  }

  List<Map<String, String>> offTimes(DateTime date) {
    final isWeekend =
        date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
    List<Map<String, String>> bikeAndPublicModes = [
      {'mode': TransportMode.bicycle.name},
    ];
    if (!isWeekend) {
      if (date.hour < 6 ||
          date.hour >= 9 && date.hour < 16 ||
          date.hour >= 18) {
        bikeAndPublicModes.add({'mode': TransportMode.transit.name});
      }
    } else {
      bikeAndPublicModes.add({'mode': TransportMode.transit.name});
    }
    return bikeAndPublicModes;
  }
}

extension on TriangleFactor {
  static const customValues = <TriangleFactor, Map<String, double>>{
    TriangleFactor.lessPublicTransport: {
      'safetyFactor': 1,
      'slopeFactor': 0,
      'timeFactor': 0
    },
    TriangleFactor.normal: null,
    TriangleFactor.morePublicTransport: {
      'safetyFactor': 0,
      'slopeFactor': 0,
      'timeFactor': 1
    },
    TriangleFactor.unknown: null,
  };
  Map<String, double> get customValue => customValues[this];
}
