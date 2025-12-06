import 'package:cosmetics_app/core/components/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Cart"), ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 34, top: 30),
              child: Text(
                "You have 4 products in your cart",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0x434C6D8C).withValues(alpha: .55),
                ),
              ),
            ),

            Expanded(
              child: ListView.separated(

                itemBuilder: (context, index) => _Item(),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Divider(),
                ),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item();

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AppImage(
                image:
                    "https://www.sephora.com/productimages/sku/s2474138-main-zoom.jpg?imwidth=2000",
                width: 102.w,
                height: 102.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 6.0, top: 6),
              child: AppImage(image: "delete.svg", width: 19.w, height: 19.h),
            ),
          ],
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff3B4569),
                  ),
                  children: [
                    TextSpan(text: "Note Cosmetics\n"),
                    TextSpan(
                      text: "Ultra rich mascara for lashes\n\n",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0x3B4569BA).withValues(alpha: .73),
                      ),
                    ),
                    TextSpan(text: "350 EGP"),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,

                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xff8E8EA9)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (count > 1 ) {
                            count--;
                          }
                          setState(() {});
                        },
                        icon: AppImage(image: "minus.svg", color: Colors.black),
                      ),
                      Text(
                        "$count",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xff434C6D),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          count++;
                          setState(() {});
                        },
                        icon: AppImage(image: "plus.svg"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
