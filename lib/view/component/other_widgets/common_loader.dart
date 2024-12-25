

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key, this.size = 60});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: size,
          width: size,
          child: const CircularProgressIndicator()),
    );
  }
}
