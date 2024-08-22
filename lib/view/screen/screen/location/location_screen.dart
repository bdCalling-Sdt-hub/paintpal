import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paintpal/controllers/google%20map/google_map_controller.dart';

import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/google_map/google_map.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    ShowGoogleMapController.instance.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ShowGoogleMapController>(
        builder: (controller) => ShowGoogleMap(
          onTapLatLong: (value) => print(value),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("object");
          final GoogleMapController googleMapController =
              await ShowGoogleMapController.instance.controller.future;
          await googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(const CameraPosition(
                  target: LatLng(23.02, 90.36), zoom: 14)));

          setState(() {});
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 1,
      ),
    );
  }
}
