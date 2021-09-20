import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trufi_core/blocs/configuration/models/itinerary_creator.dart';

import 'package:trufi_core/entities/plan_entity/plan_entity.dart';
import 'package:trufi_core/models/enums/enums_plan/enums_plan.dart';
import 'package:trufi_core/models/enums/enums_plan/icons/other_icons.dart';
import 'package:trufi_core/widgets/map/utils/trufi_map_utils.dart';

class CustomItineraryCreator implements ItinararyCreator {
  const CustomItineraryCreator();
  @override
  Map<PlanItinerary, List<PolylineWithMarkers>> buildItineraries({
    @required PlanEntity plan,
    @required PlanItinerary selectedItinerary,
    @required Function(PlanItinerary p1) onTap,
  }) {
    final Map<PlanItinerary, List<PolylineWithMarkers>> itineraries = {};
    if (plan != null) {
      for (final itinerary in plan.itineraries) {
        final List<Marker> markers = [];
        final List<PolylineWithMarkers> polylinesWithMarkers = [];
        final bool isSelected = itinerary == selectedItinerary;
        final bool showOnlySelected = selectedItinerary.isOnlyShowItinerary;
        if (!showOnlySelected || isSelected) {
          final List<PlanItineraryLeg> compressedLegs = itinerary.compressLegs;
          for (int i = 0; i < compressedLegs.length; i++) {
            final PlanItineraryLeg leg = compressedLegs[i];
            // Polyline
            final List<LatLng> points = leg.accumulatedPoints.isNotEmpty
                ? leg.accumulatedPoints
                : decodePolyline(leg.points);
            final Color color = isSelected
                ? leg.transportMode == TransportMode.bicycle &&
                        leg.fromPlace.bikeRentalStation != null
                    ? getBikeRentalNetwork(
                            leg.fromPlace.bikeRentalStation.networks[0])
                        .color
                    : (leg?.route?.color != null
                        ? Color(int.tryParse("0xFF${leg.route.color}"))
                        : (leg.transportMode == TransportMode.bicycle
                            ? const Color(0xFF333333).withOpacity(0.5)
                            : leg.transportMode.backgroundColor))
                : Colors.grey;

            final Polyline polyline = Polyline(
              points: points,
              color: color,
              strokeWidth: isSelected ? 8.0 : 3.0,
              isDotted: leg.transportMode == TransportMode.walk,
            );

            // Bus marker
            if (leg.transportMode != TransportMode.walk &&
                leg.transportMode != TransportMode.bicycle &&
                leg.transportMode != TransportMode.car) {
              // Transfer marker transport
              if (isSelected &&
                  i < compressedLegs.length - 1 &&
                  polyline.points.isNotEmpty) {
                markers.add(
                  buildTransferMarkerBig(
                    polyline.points[polyline.points.length - 1],
                    color: leg?.route?.color != null
                        ? Color(int.tryParse("0xFF${leg.route.color}"))
                        : leg.transportMode.backgroundColor,
                  ),
                );
                markers.add(
                  buildTransferMarkerBig(
                    polyline.points[0],
                    color: leg?.route?.color != null
                        ? Color(int.tryParse("0xFF${leg.route.color}"))
                        : leg.transportMode.backgroundColor,
                  ),
                );
              }

              markers.add(
                buildBusMarker(
                  midPointForPolyline(polyline),
                  isSelected
                      ? (leg?.route?.color != null
                          ? Color(int.tryParse("0xFF${leg.route.color}"))
                          : leg.transportMode.backgroundColor)
                      : Colors.grey,
                  leg,
                  icon: (leg?.route?.type ?? 0) == 715
                      ? onDemandTaxiSvg(color: 'FFFFFF')
                      : null,
                  onTap: () => onTap(itinerary),
                  showIcon: false,
                ),
              );
            }
            if (leg.transportMode == TransportMode.bicycle && isSelected) {
              final Polyline polyline2 = Polyline(
                points: points,
                color: const Color(0xFF333333),
                strokeWidth: 4,
                isDotted: leg.transportMode == TransportMode.walk,
              );
              polylinesWithMarkers.add(PolylineWithMarkers(polyline2, []));
            }
            polylinesWithMarkers.add(PolylineWithMarkers(polyline, markers));
          }
        }
        itineraries.addAll({itinerary: polylinesWithMarkers});
      }
    }
    return itineraries;
  }

  Marker buildTransferMarkerBig(LatLng point,
      {Color color = Colors.black, double size = 22}) {
    return Marker(
      point: point,
      width: size,
      height: size,
      anchorPos: AnchorPos.align(AnchorAlign.center),
      builder: (context) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
