import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  const AppButton({super.key, this.text = "",  this.onPressed,  this.color});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style:FilledButton.styleFrom(
        backgroundColor: color
      ) ,

        onPressed:onPressed, child: Text(text));
  }
}
