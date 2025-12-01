import 'package:cosmetics_app/core/components/app_image.dart';
import 'package:cosmetics_app/views/home/pages/cart.dart';
import 'package:cosmetics_app/views/home/pages/categories.dart';
import 'package:cosmetics_app/views/home/pages/home.dart';
import 'package:cosmetics_app/views/home/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final list = [
    _Model("home.icons", HomePage()),
    _Model("categories.icons", CategoriesPage()),
    _Model("my_cart.icons", CartPage()),
    _Model("profile.icons", ProfilePage()),
  ];

  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[currentIndex].pages,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 13),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 6,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: Colors.black.withValues(alpha: .10),
            ),
            BoxShadow(
              offset: Offset(-4, -4),
              blurRadius: 6,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: Colors.black.withValues(alpha: .10),
            ),
          ],
          borderRadius: BorderRadius.circular(25),
          color: Color(0xffD9D9D9),
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          currentIndex: currentIndex,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: List.generate(
            list.length,
            (index) => BottomNavigationBarItem(
              icon: AppImage(
                image: list[index].icon,
                color: currentIndex == index
                    ? Theme.of(context).primaryColor
                    : null,
              ),
              // icon: SvgPicture.asset(
              //   "assets/images/${list[index].icon}",
              //   color: currentIndex == index
              //       ? Theme.of(context).primaryColor
              //       : null,
              // ),
              label: "",
            ),
          ),
        ),
      ),
    );
  }
}

class _Model {
  final String icon;
  final Widget pages;

  _Model(this.icon, this.pages);
}
