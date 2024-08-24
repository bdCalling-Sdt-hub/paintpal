import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controllers/google map/google_map_controller.dart';
import '../../../models/place_model.dart';
import '../../../services/location_service.dart';
import '../../screen/screen/location/widgets/bottom_sheet.dart';


class ShowGoogleMap extends StatelessWidget {
  ShowGoogleMap(
      {super.key,
      this.latitude = 0,
      this.longitude = 0,
      required this.onTapLatLong});

  final double latitude;

  final double longitude;
  Function(LatLng value) onTapLatLong;

  ShowGoogleMapController showGoogleMapController =
      Get.put(ShowGoogleMapController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowGoogleMapController>(
      builder: (controller) {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: controller.kGooglePlex,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          cameraTargetBounds: CameraTargetBounds.unbounded,
          onTap: (LatLng latLng) {
            onTapLatLong(latLng);
            // controller.setMarker(latLng);
          },
          markers: Set<Marker>.of(controller.marker),
          onMapCreated: (GoogleMapController googleMapController) {
            controller.controller.complete(googleMapController);
          },
        );
      },
    );
  }
}


