import 'dart:math';

import 'package:cosmetics_app/core/logic/dio_helper.dart'; // تأكد من استيراد المسار الصحيح
import 'package:cosmetics_app/core/logic/end_points.dart';
import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/ui/app_image.dart';
import '../../../check_out.dart';
import 'components/model.dart';

part 'components/item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartResponseModel? model;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCartData();
  }

  Future<void> getCartData() async {
    try {
      final resp = await DioHelper.getData(EndPoints.cart);

      if (resp != null) {
        model = CartResponseModel.fromJson(resp);
      }
    } catch (e) {
      debugPrint("Error fetching cart: $e");
    } finally {
      isLoading = false;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 24.0),
            child: GestureDetector(
              onTap: () {
                goTo(page: const CheckOutView());
              },
              child: const AppImage(image: "shopping_checkout.svg"),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : model == null || model!.items.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 34,
                      top: 30,
                    ),
                    child: Text(
                      "You have ${model!.items.length} products in your cart",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: const Color(0xff434C6D).withOpacity(0.55),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: ListView.separated(
                        itemBuilder: (context, index) => _Item(
                          itemModel: model!.items[index],
                          onDelete: () {
                            setState(() {
                              model!.items.removeAt(index);
                            });
                          },
                        ),

                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0),
                          child: Divider(),
                        ),
                        itemCount: model!.items.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
