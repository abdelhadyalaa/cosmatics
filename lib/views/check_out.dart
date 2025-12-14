import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/core/ui/app_back.dart';
import 'package:cosmetics_app/core/ui/app_button.dart';
import 'package:cosmetics_app/core/ui/app_image.dart';
import 'package:cosmetics_app/views/pin_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    final position = LatLng(31.0414531, 31.34164);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: AppBack(startPadding: 16),
        title: Text("Checkout"),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            color: Color(0xff29D3DA).withValues(alpha: .11),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(28.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Delivery to",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff434C6D),
                  ),
                ),
                SizedBox(height: 18.h),
                _Title(
                  title: "Home",
                  subTitle: "Mansoura, 14 Porsaid St",
                  leading: SizedBox(
                    height: 60.h,
                    width: 97.w,
                    child: GestureDetector(
                      onTap: () {
                        goTo(page: PinLocationView());
                        // MapsLauncher.launchCoordinates(
                        //   position.latitude,
                        //   position.longitude,
                        // );
                      },
                      child: AbsorbPointer(
                        child: GoogleMap(
                          markers: {
                            Marker(
                              markerId: MarkerId("myLocation"),
                              position: position,
                            ),
                          },
                          myLocationButtonEnabled: false,
                          liteModeEnabled: true,
                          initialCameraPosition: CameraPosition(
                            zoom: 16,
                            target: position,
                          ),
                        ),
                      ),
                    ),
                  ),
                  bottomSpace: 40.h,
                ),
                Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff434C6D),
                  ),
                ),
                SizedBox(height: 18.h),
                _Title(
                  title: "**** **** **** 0256",
                  leadingImage: "meza.svg",
                  bottomSpace: 12.h,
                ),
                _Title(
                  title: "Add vaucher",
                  leadingImage: "voucher.svg",
                  trailing: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: AppButton(text: "Apply", onPressed: () {}),
                  ),
                  bottomSpace: 32.h,
                ),
                Text(
                  "-" * 100,
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0x434C6D4F).withValues(alpha: .31),
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  "- REVIEW PAYMENT",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff434C6D),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "PAYMENT SUMMARY",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff434C6D),
                  ),
                ),
                SizedBox(height: 40.h),
                _TextDetails(value: "16.100 EGP", title: "Subtotal"),
                _TextDetails(value: "TO BE CALCULATED", title: "SHIPPING FEES"),
                SizedBox(height: 20.h),
                Divider(color: Color(0xff73B9BB)),
                SizedBox(height: 30.h),
                _TextDetails(
                  title: "TOTAL + VAT",
                  value: "16.100 EGP",
                  valueFontWeight: FontWeight.bold,
                ),
                SizedBox(height: 25.h),
                AppButton(icon: "order.svg", text: "ORDER", onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final String? subTitle;
  final double? bottomSpace;
  final String? leadingImage;
  final Widget? leading, trailing;

  const _Title({
    super.key,
    required this.title,
    this.subTitle,
    this.leadingImage,
    this.leading,
    this.trailing,
    this.bottomSpace = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
      ).copyWith(bottom: bottomSpace),
      child: ListTile(
        contentPadding: leading != null ? EdgeInsets.all(12.r) : null,
        horizontalTitleGap: 10.w,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
          side: BorderSide(color: Color(0xff73B9BB), width: 1.5),
        ),
        leading: leading ?? AppImage(image: leadingImage ?? ""),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
            SizedBox(height: 10.h),
            if (subTitle != null)
              Text(
                subTitle!,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
              ),
          ],
        ),

        trailing: trailing ?? AppImage(image: "down.svg"),
      ),
    );
  }
}

class _TextDetails extends StatelessWidget {
  final String title, value;
  final FontWeight valueFontWeight;

  const _TextDetails({
    super.key,
    required this.title,
    required this.value,
    this.valueFontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff434C6D),
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: valueFontWeight,
              color: Color(0xff434C6D),
            ),
          ),
        ],
      ),
    );
  }
}
