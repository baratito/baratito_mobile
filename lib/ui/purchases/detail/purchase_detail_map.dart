import 'dart:typed_data';

import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:baratito_mobile/ui/purchases/detail/marker_generator.dart';
import 'package:baratito_mobile/ui/purchases/detail/marker_colors_utils.dart';

class PurchaseDetailMap extends StatefulWidget {
  final PurchaseList purchaseList;

  const PurchaseDetailMap({
    Key? key,
    required this.purchaseList,
  }) : super(key: key);

  @override
  _PurchaseDetailMapState createState() => _PurchaseDetailMapState();
}

class _PurchaseDetailMapState extends State<PurchaseDetailMap> {
  final _markers = <Marker>[];

  @override
  void initState() {
    _setUpMarkers();
    super.initState();
  }

  void _setUpMarkers() {
    MarkerGenerator(
      markerWidgets: [
        ..._buildEstablishmentMarkers(),
        _buildUserLocationMarker(),
      ],
      callback: (bitmaps) {
        final establishmentImages = bitmaps.sublist(0, bitmaps.length - 1);
        final userLocationImage = bitmaps.last;
        setState(() {
          _mapEstablishmentBitmapsToMarkers(establishmentImages);
          _mapUserLocationBitmapToMarker(userLocationImage);
        });
      },
    ).generate(context);
  }

  @override
  Widget build(BuildContext context) {
    final firstEstablishmentLocation =
        widget.purchaseList.establishments.first.establishment.location;
    return GoogleMap(
      zoomControlsEnabled: false,
      tiltGesturesEnabled: false,
      polylines: {_getPolyline()},
      markers: _markers.toSet(),
      initialCameraPosition: CameraPosition(
        target: LatLng(
          firstEstablishmentLocation.latitude,
          firstEstablishmentLocation.longitude,
        ),
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        setState(() {
          controller.animateCamera(
            CameraUpdate.newLatLngBounds(_getBounds(), 50),
          );
        });
      },
    );
  }

  void _mapEstablishmentBitmapsToMarkers(List<Uint8List> bitmaps) {
    final purchaseEstablishments = widget.purchaseList.establishments;
    final establishments = purchaseEstablishments.map((e) {
      return e.establishment;
    }).toList();
    bitmaps.asMap().forEach(
      (index, bitmap) {
        final establishment = establishments[index];
        final location = establishment.location;
        _markers.add(
          Marker(
            markerId: MarkerId('${establishment.id}'),
            position: LatLng(location.latitude, location.longitude),
            icon: BitmapDescriptor.fromBytes(bitmap),
          ),
        );
      },
    );
  }

  void _mapUserLocationBitmapToMarker(Uint8List bitmap) {
    final location = widget.purchaseList.startingPoint;
    _markers.add(
      Marker(
        markerId: const MarkerId('user-location'),
        position: LatLng(location.latitude, location.longitude),
        icon: BitmapDescriptor.fromBytes(bitmap),
      ),
    );
  }

  List<Widget> _buildEstablishmentMarkers() {
    final purchaseEstablishments = widget.purchaseList.establishments;
    final establishments = purchaseEstablishments.map((e) {
      return e.establishment;
    }).toList();
    final colors = getMarkerColors(context);
    final widgets = <Widget>[];
    for (var index = 0; index < establishments.length; index++) {
      final establishment = establishments[index];
      final color = colors[index];
      final label = establishment.brand.isNotEmpty
          ? establishment.brand
          : establishment.name;
      widgets.add(LabelMarker(label: label, color: color));
    }
    return widgets;
  }

  Widget _buildUserLocationMarker() {
    return IconMarker(
      icon: BaratitoIcons.home,
      color: context.themeValue.colors.background,
    );
  }

  LatLngBounds _getBounds() {
    final boundaries = widget.purchaseList.boundaries;
    final southwest = boundaries.southwest;
    final southwestCoords = LatLng(southwest.latitude, southwest.longitude);
    final northeast = boundaries.northeast;
    final northeastCoords = LatLng(northeast.latitude, northeast.longitude);
    return LatLngBounds(
      southwest: southwestCoords,
      northeast: northeastCoords,
    );
  }

  Polyline _getPolyline() {
    final decoder = PolylinePoints();
    final decodedPoints = decoder.decodePolyline(widget.purchaseList.polyline);
    final polylinePoints = decodedPoints.map<LatLng>((point) {
      return LatLng(point.latitude, point.longitude);
    }).toList();
    return Polyline(
      polylineId: PolylineId(widget.purchaseList.polyline),
      color: context.theme.colors.background.withOpacity(.6),
      points: polylinePoints,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      width: 6,
    );
  }
}
