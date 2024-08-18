import 'package:flutter/material.dart';

import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/google_map/google_map.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowGoogleMap(
        // ignore: avoid_print
        onTapLatLong: (value) => print(value),
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 1,
      ),
    );
  }
}
