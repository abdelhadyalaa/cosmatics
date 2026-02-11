import 'dart:math'; // مهم جداً عشان Random يشتغل
import 'package:dio/dio.dart' show Dio;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/logic/dio_helper.dart';
import '../../../../core/logic/end_points.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_search.dart';

part 'components/item.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<CategoryModel>? list;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final resp = await DioHelper(dio: Dio()).getData(EndPoints.categoriesHome);
      if (resp != null && resp is List) {
        list = resp.map((e) => CategoryModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : list == null || list!.isEmpty
            ? const Center(child: Text("No Categories Found"))
            : SingleChildScrollView(
          padding: EdgeInsets.all(13.r),
          child: Column(
            children: [
              const AppSearch(),
              ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 13.w,
                  vertical: 30.h,
                ).copyWith(bottom: 100.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list!.length,
                itemBuilder: (context, index) => _Item(
                  model: list![index],
                ),
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: const Divider(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryModel {
  late final int id;
  late final String title;
  late final String imageUrl;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    imageUrl = json['imageUrl'] ?? "";
  }
}