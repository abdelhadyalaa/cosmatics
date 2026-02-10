import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResendOtp extends StatefulWidget {
  final VoidCallback onResend;

  const AppResendOtp({super.key, required this.onResend});

  @override
  State<AppResendOtp> createState() => _AppResendOtpState();
}

class _AppResendOtpState extends State<AppResendOtp> {
  bool isCodeSent = true;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Didn't receive a code?",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: const Color(0xff434C6D),
          ),
        ),
        TextButton(
          onPressed: isCodeSent
              ? null
              : () {
            widget.onResend();

            setState(() => isCodeSent = true);
            _controller.restart(duration: 90);
          },
          child: Text(
            "Resend",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: isCodeSent ? Colors.grey : const Color(0xffD75D72),
            ),
          ),
        ),
        const Spacer(),
        if (isCodeSent)
          CircularCountDownTimer(
            key: const ValueKey("otp_timer"),
            controller: _controller,
            width: 30.w,
            height: 30.h,
            duration: 90,
            initialDuration: 0,
            ringColor: Colors.grey[200]!,
            fillColor: const Color(0xffD75D72),
            backgroundColor: Colors.transparent,
            strokeWidth: 3.0,
            textStyle: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff434C6D),
            ),
            textFormat: CountdownTextFormat.MM_SS,
            isReverse: true,
            isTimerTextShown: true,
            autoStart: true,
            onComplete: () {
              if (mounted) {
                setState(() => isCodeSent = false);
              }
            },
          ),
      ],
    );
  }
}
