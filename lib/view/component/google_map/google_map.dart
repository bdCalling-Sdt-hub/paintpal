import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/location_service.dart';
import '../../../utils/app_images.dart';



class ShowGoogleMap extends StatefulWidget {
  ShowGoogleMap(
      {super.key,
      this.latitude = 0,
      this.longitude = 0,
      required this.onTapLatLong});

  double latitude;

  double longitude;
  Function(LatLng value) onTapLatLong;

  @override
  State<ShowGoogleMap> createState() => _ShowGoogleMapState();
}

class _ShowGoogleMapState extends State<ShowGoogleMap> {
  ShowGoogleMapController showGoogleMapController =
      Get.put(ShowGoogleMapController());

  @override
  void initState() {
    showGoogleMapController.getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    showGoogleMapController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowGoogleMapController>(
      builder: (controller) {
        return GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition: controller.kGooglePlex,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          cameraTargetBounds: CameraTargetBounds.unbounded,
          onTap: (LatLng latLng) {
            widget.onTapLatLong(latLng);
            controller.setMarker(latLng);
          },
          markers: Set<Marker>.of(controller.markers.map((marker) {
            return marker;
          })),
          onMapCreated: (GoogleMapController googleMapController) {
            if (controller.controller.isCompleted) {
              controller.controller.complete(googleMapController);
            }
          },
        );
      },
    );
  }
}

class ShowGoogleMapController extends GetxController {
  double latitude = 0;
  double longitude = 0;
  List<Marker> markers = [];

  markerIcon() async {
    return await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), AppImages.marker);
  }

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  var kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  setMarker(LatLng latLng) async {
    Marker newMarker = Marker(
        markerId: const MarkerId("1"),
        icon: await markerIcon(),
        position: LatLng(latLng.latitude, latLng.longitude));
    latitude = latLng.latitude;
    longitude = latLng.longitude;

    markers.add(newMarker);
    update();
    CameraPosition newCameraPosition = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(latitude, longitude),
        tilt: 59.440717697143555,
        zoom: 14);

    final GoogleMapController googleMapController = await controller.future;
    await googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  getCurrentLocation() async {
    Position? positions = await LocationService.getCurrentPosition();

    if (kDebugMode) {
      print("current location $positions");
    }
    if (positions != null) {
      CameraPosition newCameraPosition = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(positions.latitude, positions.longitude),
          tilt: 59.440717697143555,
          zoom: 14);

      final GoogleMapController googleMapController = await controller.future;
      await googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    }
  }
}
