part of '../view.dart';

class _Item extends StatefulWidget {
  final CartItemModel itemModel;
  final VoidCallback onDelete;

  const _Item({required this.itemModel, required this.onDelete});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  late int count;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    count = widget.itemModel.quantity;
  }

  Future<void> deleteData() async {
    if (isUpdating) return;
    setState(() => isUpdating = true);

    try {
      final resp = await DioHelper.deleteData(
        EndPoints.deleteCart,
        queryParameters: {"productId": widget.itemModel.productId},
      );

      if (resp != null && resp["message"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(resp["message"]),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        widget.onDelete();
      }
    } catch (e) {
      debugPrint("Delete cart item error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete item"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isUpdating = false);
    }
  }

  Future<void> updateQuantity(int newCount) async {
    if (isUpdating) return;
    setState(() => isUpdating = true);

    try {
      final resp = await DioHelper.putData(
        EndPoints.updateCart,

        queryParameters: {
          "productId": widget.itemModel.productId,
          "quantity": newCount,
        },
      );



      setState(() {
        count = newCount;
      });
    } catch (e) {
      debugPrint("Update quantity error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to update quantity"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isUpdating = false);
    }
  }

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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: AppImage(
                image: widget.itemModel.imageUrl,
                width: 102.w,
                height: 102.h,
                fit: BoxFit.cover,
                errorImage: list[Random().nextInt(list.length)],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 6.0, top: 6),
              child: GestureDetector(
                onTap: deleteData,
                child: AppImage(image: "delete.svg", width: 20.w, height: 20.h),
              ),
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
                          if (count > 1 && !isUpdating) {
                            updateQuantity(count - 1);
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
                          if (!isUpdating) updateQuantity(count + 1);
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
