import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_search.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});

  final list = [
    "https://i.pinimg.com/736x/dd/81/55/dd815570f18b9f13a54a566ef2f4a732.jpg",
    "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=1000&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1512496015851-a90fb38ba796?q=80&w=1000&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1571781926291-c477ebfd024b?q=80&w=1000&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?q=80&w=1000&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1612817288484-6f916006741a?q=80&w=1000&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=1000&auto=format&fit=crop",
  ];
  final listText = ["Bundles", "Gifts", "Makeup", "Skin Care", "Perfumes"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(13),
          child: Column(
            children: [
              AppSearch(),
              ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 30,
                ).copyWith(bottom: 100),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemBuilder: (context, index) =>
                    _Item(imageUrl: list[index], text: listText[index]),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Divider(),
                ),
                itemCount: listText.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String imageUrl, text;

  const _Item({required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: AppImage(
            image: imageUrl,
            width: 64.w,
            height: 69.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: Color(0xff434C6D),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: AppImage(image: "forward.svg"),
        ),
      ],
    );
  }
}
