import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../models/place_model.dart';
import '../../../services/location_service.dart';
import '../../screen/screen/location/widgets/bottom_sheet.dart';
import 'package:http/http.dart' as http;

class ShowGoogleMap extends StatefulWidget {
  ShowGoogleMap(
      {super.key,
      this.latitude = 0,
      this.longitude = 0,
      required this.onTapLatLong});

  final double latitude;

  final double longitude;
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
            widget.onTapLatLong(latLng);
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

class ShowGoogleMapController extends GetxController {
  List<Marker> marker = [];

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  var kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  setMarker(LatLng latLng) async {
    Marker newMarker = Marker(
        markerId: const MarkerId("1"),
        position: LatLng(latLng.latitude, latLng.longitude));

    marker.add(newMarker);
    update();
    CameraPosition newCameraPosition = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(latLng.latitude, latLng.longitude),
        tilt: 59.440717697143555,
        zoom: 14);
  }

  getCurrentLocation() async {
    Position? positions = await LocationService.getCurrentPosition();
    if (positions != null) {
      CameraPosition newCameraPosition = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(positions.latitude, positions.longitude),
          tilt: 59.440717697143555,
          zoom: 14);

      fetchNearbyPlaces(positions);
      final GoogleMapController googleMapController = await controller.future;
      await googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    }
  }

  Future<void> fetchNearbyPlaces(positions) async {
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBT1HkkjBVBLJVm0pWHdj6WcG_gnUmaoaE',
      'X-Goog-FieldMask':
          'places.displayName,places.formattedAddress,places.location'
    };
    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));
    request.body = json.encode({
      "includedTypes": ["hardware_store"],
      "maxResultCount": 10,
      "locationRestriction": {
        "circle": {
          "center": {
            "latitude": positions.latitude,
            "longitude": positions.longitude
          },
          "radius": 1000
        }
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("places ${response.statusCode}");

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();

      List places = jsonDecode(data)["places"];

      print("places ${places}");

      for (int i = 0; i < places.length; i++) {
        PlaceModel placeModel = PlaceModel.fromJson(places[i]);

        print("placeModel.location.latitude ${placeModel.location.latitude}");

        Marker newMarker = Marker(
            markerId: MarkerId("${marker.length}"),
            infoWindow: InfoWindow(
              title: placeModel.displayName.text,
              onTap: () => MakePayment.makePaymentSheet(placeModel),
            ),
            position: LatLng(
                placeModel.location.latitude, placeModel.location.longitude));

        marker.add(newMarker);
      }

      print(marker.length);

      update();
      print(data);
    } else {
      print(response.reasonPhrase);
    }
  }
}
