part of '../view.dart';

class _Item extends StatelessWidget {
  final CategoryModel model;

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

    return InkWell(
      onTap: () {
        debugPrint("Selected Category ID: ${model.id}");
      },
      borderRadius: BorderRadius.circular(10.r),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              model.imageUrl,
              width: 64.w,
              height: 69.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => AppImage(
                image: list[Random().nextInt(list.length)],
                width: 64.w,
                height: 69.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              model.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: const Color(0xff434C6D),
              ),
            ),
          ),
          const AppImage(
            image: "forward.svg",
          ),
        ],
      ),
    );
  }
}