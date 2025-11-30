import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/on_boarding3.png",
              width: 283,
              height: 259,
            ),
            SizedBox(height: 27),
            Text(
              "PUCH NOTIFICATIONS ",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff434C6D),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40),
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff434C6D),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                "Allow notifications for new makeup & cosmetics offers.",
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(

              style: ElevatedButton.styleFrom(

                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                backgroundColor: Color(0xff434C6D),
              ),
              onPressed: () {},
              child: Text("let’s start!",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
