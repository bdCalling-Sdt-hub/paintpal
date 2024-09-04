import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controllers/google map/google_map_controller.dart';

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
          initialCameraPosition: controller.kGooglePlex ??
              const CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14,
              ),
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
