import 'package:cosmetics_app/core/components/app_image.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: AppImage(image: "search.svg",height: 18,width: 18,)
      ),
    );
  }
}
