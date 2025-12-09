import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResendOtp extends StatefulWidget {
  const AppResendOtp({super.key});

  @override
  State<AppResendOtp> createState() => _AppResendOtpState();
}

class _AppResendOtpState extends State<AppResendOtp> {
  bool isCodeSent = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Didn't recieve a code?",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: Color(0xff434C6D),
          ),
        ),
        TextButton(
          onPressed: isCodeSent
              ? null
              : () {
                  isCodeSent = true;
                  setState(() {});
                },
          child: Text(
            "Resend",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              // color: Color(0xffD75D72),
            ),
          ),
        ),
        Spacer(),
        if (isCodeSent)
          CircularCountDownTimer(
            onComplete: () {
              isCodeSent = false;
              setState(() {});
            },
            width: 40.w,
            height: 50.h,
            duration: 90,
            textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textFormat: CountdownTextFormat.MM_SS,
            fillColor: Colors.transparent,
            ringColor: Colors.transparent,
            isReverse: true,
          ),
      ],
    );
  }
}
