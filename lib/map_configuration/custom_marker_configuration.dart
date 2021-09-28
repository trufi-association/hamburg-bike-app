import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:trufi_core/models/markers/marker_configuration.dart';
import 'package:trufi_core/models/markers/markers_default/from_marker_default.dart';
import 'package:trufi_core/models/markers/markers_default/to_marker_default.dart';
import 'package:trufi_core/models/markers/markers_default/your_location_marker.dart';

class CustomMarkerConfiguration implements MarkerConfiguration {
  const CustomMarkerConfiguration();

  @override
  Widget get fromMarker => const FromMarkerDefault();

  @override
  Widget get toMarker => const ToMarkerDefault();

  @override
  Widget get yourLocationMarker => const MyLocationMarker();

  @override
  Marker buildFromMarker(LatLng point) {
    return Marker(
      point: point,
      width: 23.0,
      height: 23.0,
      anchorPos: AnchorPos.align(AnchorAlign.center),
      builder: (context) {
        return Container(
          decoration:
              BoxDecoration(color: Color(0xff333333), shape: BoxShape.circle),
          child: Icon(
            Icons.directions_bike,
            color: Colors.white,
            size: 14,
          ),
        );
      },
    );
  }

  @override
  Marker buildToMarker(LatLng point) {
    return Marker(
      point: point,
      width: 23.0,
      height: 23.0,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      builder: (context) {
        return Container(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(width: 10, height: 10, color: Colors.white),
              const Icon(Icons.location_on, size: 30, color: Color(0xff333333))
            ],
          ),
        );
      },
    );
  }

  @override
  Marker buildYourLocationMarker(LatLng point) {
    return (point != null)
        ? Marker(
            width: 50.0,
            height: 50.0,
            point: point,
            anchorPos: AnchorPos.align(AnchorAlign.center),
            builder: (context) => const MyLocationMarker(),
          )
        : Marker(
            width: 0,
            height: 0,
            point: LatLng(0, 0),
            builder: (_) => Container());
  }

  @override
  MarkerLayerOptions buildFromMarkerLayerOptions(LatLng point) {
    return MarkerLayerOptions(markers: [buildFromMarker(point)]);
  }

  @override
  MarkerLayerOptions buildToMarkerLayerOptions(LatLng point) {
    return MarkerLayerOptions(markers: [buildToMarker(point)]);
  }

  @override
  MarkerLayerOptions buildYourLocationMarkerLayerOptions(LatLng point) {
    return MarkerLayerOptions(markers: [buildYourLocationMarker(point)]);
  }
}
