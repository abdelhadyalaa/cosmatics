part of '../view.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232.h,
      child: Stack(
        children: [
          Container(
            height: 152.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.bottomCenter,
                end: AlignmentDirectional.topCenter,
                stops: [0, 1],
                colors: [
                  Color(0xffECA4C5),
                  Color(0x434C6DD4).withValues(alpha: .83),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppImage(
                  isCircle: true,
                  height: 96.h,
                  width: 96.w,
                  image:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTefdAYZ6uy2rn4ODl9zSL1KwCAhiEPo9Xm-g&s",
                ),
                SizedBox(height: 16.h),
                Text(
                  "Sara Samer Talaat",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
