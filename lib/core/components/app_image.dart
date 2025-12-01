import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String image;
  final double? height, width;
  final Color? color;
  final BoxFit fit;

  const AppImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.scaleDown,
  });

  @override
  Widget build(BuildContext context) {
    if (image.toLowerCase().endsWith("svg")) {
      return SvgPicture.asset(
        "assets/icons/$image",
        color: color,
        height: height,
        width: width,
        fit: fit,
      );
    } else if (image.startsWith("http")) {
      return Image.network(
        image,
        height: height,
        width: width,
        color: color,
        fit: fit,
      );
    }
    return Image.asset(
      "assets/images/$image",
      height: height,
      width: width,
      color: color,
      fit: fit,
    );
  }
}
