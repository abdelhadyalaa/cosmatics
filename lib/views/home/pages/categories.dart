import 'package:flutter/material.dart';

import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_search.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(13),
          child: Column(
            children: [
              AppSearch(

              ),
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 13,vertical: 30).copyWith(bottom: 100),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemBuilder: (context, index) => _Item(),
                separatorBuilder: (context, index) => Padding(

                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Divider(),
                ),
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(image: "https://i.pinimg.com/736x/dd/81/55/dd815570f18b9f13a54a566ef2f4a732.jpg", width: 64, height: 64),
        SizedBox(width: 12),
        Text(
          "Bundles",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xff434C6D),
          ),
        ),
        Spacer(),
        AppImage(image: "forward.icons"),
      ],
    );
  }
}
