import 'package:cosmetics_app/core/logic/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

import '../../../../core/logic/end_points.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_search.dart';

part 'components/offers.dart';

part 'components/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(13.r).copyWith(bottom: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSearch(),
              SizedBox(height: 13.h),
              const _Offers(),
              SizedBox(height: 24.h),
              const _ProductList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final ProductModel model;

  const _Item({required this.model});

  @override
  Widget build(BuildContext context) {
    final list = [
      "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=1000",
      "https://images.unsplash.com/photo-1512496015851-a90fb38ba796?q=80&w=1000",
      "https://images.unsplash.com/photo-1571781926291-c477ebfd024b?q=80&w=1000",
      "https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?q=80&w=1000",
      "https://images.unsplash.com/photo-1612817288484-6f916006741a?q=80&w=1000",
      "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=1000",
    ];

    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    model.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => AppImage(
                      image: list[Random().nextInt(list.length)],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 11.h),
              Text(
                model.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff434C6D),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "${model.price} EGP",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff70839C),
                ),
              ),
            ],
          ),
          PositionedDirectional(
            top: 5,
            end: 5,
            child: GestureDetector(
              onTap: () async {
                try {
                  final resp = await DioHelper.postData(
                    EndPoints.addCart,
                    queryParameters: {"productId": model.id, "quantity": 1},
                  );

                  if (resp != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(resp["message"] ?? "Item added to cart."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                } catch (e) {
                  debugPrint("Add to cart error: $e");
                }
              },
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(5.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: AppImage(image: "cart.svg", width: 18.w, height: 18.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
