import 'package:cosmetics_app/core/components/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInput extends StatelessWidget {
  final String? suffixIcon, hint, label;
  final bool withCountryCode ;

  const AppInput({super.key, this.suffixIcon, this.hint = "", this.label = "",  this.withCountryCode = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          if(withCountryCode)
          DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),

                border: Border.all(color: Theme
                    .of(context)
                    .inputDecorationTheme
                    .enabledBorder!
                    .borderSide
                    .color)
            ),
            child: DropdownButton<int>(
              items: [10, 20, 30, 40, 50]
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text("$e")),
              )
                  .toList(),
              onChanged: (value) {},

            ),
          ),
          Expanded(child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              isDense: true,
              hintText: hint,
              suffixIcon: suffixIcon != null
                  ? AppImage(image: suffixIcon!, height: 18, width: 18)
                  : null,
            ),
          )
          ),
        ],
      ),
    );

  }
}
