import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;

  const AppButton({super.key, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: () {}, child: Text(text));
  }
}
