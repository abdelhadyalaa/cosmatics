import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_country_code.dart';
import 'app_image.dart';

class AppInput extends StatefulWidget {
  final String? suffixIcon;
  final String hint, label;
  final bool withCountryCode, isPassword;
  final double? bottomSpace;

  const AppInput({
    super.key,
    this.suffixIcon,
    this.hint = "",
    this.label = "",
    this.withCountryCode = false,
    this.isPassword = false,
    this.bottomSpace,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomSpace ?? 16.h),
      child: Row(
        children: [
          if (widget.withCountryCode) AppCountryCode(),
          Expanded(
            child: TextFormField(
              obscureText: widget.isPassword && isHidden,
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: widget.hint,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          isHidden = !isHidden;
                          setState(() {});
                        },
                        icon: AppImage(
                          image: isHidden
                              ? "visibility_off.svg"
                              : "visibility.svg",
                        ),
                      )
                    : widget.suffixIcon != null
                    ? AppImage(image: widget.suffixIcon!, height: 18, width: 18)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
