import 'package:cosmetics_app/core/logic/cache_helper.dart';
import 'package:cosmetics_app/core/logic/dio_helper.dart';
import 'package:cosmetics_app/core/logic/end_points.dart';
import 'package:cosmetics_app/views/auth/login/view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/logic/helper_methods.dart';
import '../../../../core/ui/app_image.dart';
import '../../../auth/login/model.dart';

part 'components/header.dart';

part 'components/item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final resp = await DioHelper.getData(EndPoints.getProfile);

      user = UserModel.fromJson(resp);

      setState(() {
        isLoading = false;
      });
    } on DioException catch (e) {
      debugPrint("Profile error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
          ? const Center(child: Text("Failed to load profile"))
          : Column(
        children: [
          _Header(user!),
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
                  _Item(title: "Logout", page: LoginView()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
