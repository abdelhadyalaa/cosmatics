import 'package:cosmetics_app/core/ui/app_image.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final String? icon;
  final VoidCallback? onPressed;
  final Color? color;

  const AppButton({
    super.key,
    this.text = "",
    this.onPressed,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: icon != null ? AppImage(image: icon!) : null,
      style: FilledButton.styleFrom(backgroundColor: color),

      onPressed: onPressed,
      label: Text(text),
    );
  }
}
