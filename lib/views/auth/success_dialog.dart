import 'package:cosmetics_app/core/components/app_button.dart';
import 'package:cosmetics_app/core/components/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(24),
      children: [
        AppImage(
          image: "success.json",
          height: 100,
          width: 100,
          bottomSpace: 26.h,
        ),
        Center(
          child: Text(
            "Password Created!",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff434C6D),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          textAlign: TextAlign.center,
          "Congratulations! Your password \nhas been successfully created",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xff8E8EA9),
          ),
        ),
        SizedBox(height: 26.h,),

        AppButton(text: "Return to login", onPressed: () {}),
      ],
    );
  }
}
