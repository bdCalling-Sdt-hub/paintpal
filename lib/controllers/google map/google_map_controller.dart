import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/place_model.dart';
import '../../services/location_service.dart';
import '../../view/screen/screen/location/widgets/bottom_sheet.dart';
import 'package:http/http.dart' as http;

class ShowGoogleMapController extends GetxController {
  List<Marker> marker = [];

  num latitude = 0;
  num longitude = 0;

  List selectedOption = ["Paint Shop", "Remove Paint"];

  String selectRole = "User";

  setSelectedRole(value) {
    selectRole = value;
    update();
  }

  static ShowGoogleMapController get instance =>
      Get.put(ShowGoogleMapController());

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  CameraPosition? kGooglePlex;

  setMarker(LatLng latLng) async {
    Marker newMarker = Marker(
        markerId: const MarkerId("1"),
        position: LatLng(latLng.latitude, latLng.longitude));

    marker.add(newMarker);
    update();
  }

  getCurrentLocation() async {
    Position? positions = await LocationService.getCurrentPosition();
    if (positions != null) {
      latitude = positions.latitude;
      longitude = positions.longitude;

      kGooglePlex = CameraPosition(
        target: LatLng(positions.latitude, positions.longitude),
        zoom: 14,
      );
      CameraPosition newCameraPosition = CameraPosition(
          target: LatLng(positions.latitude, positions.longitude), zoom: 14);

      fetchNearbyRemovePaint(positions);
      final GoogleMapController googleMapController = await controller.future;
      await googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
      update();
    }
  }

  // Future<void> fetchNearbyPlaces(positions) async {
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'X-Goog-Api-Key': 'AIzaSyBT1HkkjBVBLJVm0pWHdj6WcG_gnUmaoaE',
  //     'X-Goog-FieldMask':
  //         'places.displayName,places.formattedAddress,places.location'
  //   };
  //   var request = http.Request('POST',
  //       Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));
  //   request.body = json.encode({
  //     "includedTypes": ["hardware_store"],
  //     "maxResultCount": 10,
  //     "locationRestriction": {
  //       "circle": {
  //         "center": {
  //           "latitude": positions.latitude,
  //           "longitude": positions.longitude
  //         },
  //         "radius": 1000
  //       }
  //     }
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var data = await response.stream.bytesToString();
  //
  //     List places = jsonDecode(data)["places"] ?? [];
  //
  //     for (int i = 0; i < places.length; i++) {
  //       PlaceModel placeModel = PlaceModel.fromJson(places[i]);
  //
  //       Marker newMarker = Marker(
  //           markerId: MarkerId("${marker.length}"),
  //           infoWindow: InfoWindow(
  //             title: placeModel.displayName.text,
  //             onTap: () => MakePayment.makePaymentSheet(placeModel),
  //           ),
  //           position: LatLng(
  //               placeModel.location.latitude, placeModel.location.longitude));
  //
  //       marker.add(newMarker);
  //     }
  //
  //     update();
  //   } else {}
  // }

  Future<void> fetchNearbyRemovePaint(positions) async {
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBT1HkkjBVBLJVm0pWHdj6WcG_gnUmaoaE',
      'X-Goog-FieldMask':
          'places.displayName,places.formattedAddress,places.location'
    };
    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));
    request.body = json.encode({
      "includedTypes": ["waste_management"],
      "maxResultCount": 10,
      "locationRestriction": {
        "circle": {
          "center": {
            "latitude": positions.latitude,
            "longitude": positions.longitude
          },
          "radius": 10000
        }
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();

      List places = jsonDecode(data)["places"] ?? [];

      for (int i = 0; i < places.length; i++) {
        PlaceModel placeModel = PlaceModel.fromJson(places[i]);

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

      update();
    } else {}
  }
}
