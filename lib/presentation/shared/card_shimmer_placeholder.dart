import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmerPlaceHolder extends StatelessWidget {
  double? height = 200;
  double? width = 0.0;

  CardShimmerPlaceHolder({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Card(
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: height,
              width: width,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
