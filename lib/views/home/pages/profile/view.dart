import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/logic/helper_methods.dart';
import '../../../../core/ui/app_image.dart';

part 'components/header.dart';
part 'components/item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _Header(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  _Item(title: "Edit Info", onTap: () {}),
                  _Item(title: "Order History"),
                  _Item(title: "Wallet"),
                  _Item(title: "Settings"),
                  _Item(title: "Voucher"),
                  _Item(title: "Logout"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
