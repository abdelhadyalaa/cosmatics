part of '../view.dart';

class _Item extends StatefulWidget {
  final CartItemModel itemModel;
  const _Item({required this.itemModel});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.itemModel.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                widget.itemModel.imageUrl,
                width: 102.w,
                height: 102.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 6.0, top: 6),
              child: AppImage(image: "delete.svg", width: 19.w, height: 19.h),
            ),
          ],
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff3B4569),
                  ),
                  children: [
                    TextSpan(text: "${widget.itemModel.title}\n"),
                    TextSpan(
                      text: "Product description goes here\n\n",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff3B4569).withOpacity(0.73),
                      ),
                    ),
                    TextSpan(text: "${widget.itemModel.price} EGP"),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: const Color(0xff8E8EA9)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (count > 1) {
                            count--;
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.remove, size: 18),
                      ),
                      Text(
                        "$count",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: const Color(0xff434C6D),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          count++;
                          setState(() {});
                        },
                        icon: const Icon(Icons.add, size: 18),
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
