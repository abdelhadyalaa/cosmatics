import 'package:cosmetics_app/core/components/app_image.dart';
import 'package:cosmetics_app/core/components/app_input.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppInput(),
              SizedBox(height: 13),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AppImage(
                      image:
                          "https://img.buzzfeed.com/buzzfeed-static/static/2019-08/16/2/asset/2f2486d35771/sub-buzz-2247-1565922471-1.jpg",
                      height: 320,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Color(0xffE9DCD3).withValues(alpha: .8),
                      ),
                      height: 151,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "50% OFF DISCOUNT \nCUPON CODE : 125865",
                                  style: TextStyle(
                                    color: Color(0xff62322D),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ),
                              AppImage(image: "offer.svg"),
                            ],
                          ),
                          Row(
                            children: [
                              AppImage(image: "offer.svg"),
                              Expanded(
                                child: Text(
                                  "Hurry up! \nSkin care only !",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Color(0xff434C6D),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Top rated products",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff434C6D),
                ),
              ),
              SizedBox(height: 14),

              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 176 / 237,
                ),
                itemBuilder: (context, index) => _Item(),
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
  const _Item({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),

        // color: Color(0xffD9D9D9)
      ),
    );
  }
}
