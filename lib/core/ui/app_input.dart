import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_country_code.dart';
import 'app_image.dart';

class AppInput extends StatefulWidget {
  final String? suffixIcon;
  final TextEditingController? controller;
  final String hint, label;
  final TextInputType keyboardType;
  final bool withCountryCode, isPassword, isSearch;
  final double? bottomSpace;

  final ValueChanged<String>? onCountryCodeChanged;

  const AppInput({
    super.key,
    this.suffixIcon,
    this.hint = "",
    this.label = "",
    this.withCountryCode = false,
    this.isPassword = false,
    this.bottomSpace,
    this.keyboardType = TextInputType.text,
    this.isSearch = false,
    this.controller,
    this.onCountryCodeChanged,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final double radiusValue = widget.isSearch ? 50.r : 8.r;
    final borderRadius = BorderRadius.circular(radiusValue);
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomSpace ?? 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.withCountryCode)
            AppCountryCode(
              onChanged: (code) {
                if (widget.onCountryCodeChanged != null) {
                  widget.onCountryCodeChanged!(code);
                }
              },
            ),

          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return widget.isPassword
                      ? "Please Put Your Password"
                      : 'Please Put Your Data';
                }
                return null;
              },
              obscureText: widget.isPassword && isHidden,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: borderRadius),
                enabledBorder: OutlineInputBorder(borderRadius: borderRadius),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
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
