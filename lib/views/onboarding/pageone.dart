import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Text(
              "Skip",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff434C6D),
              ),
            ),
            SizedBox(width: 40),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/on_boarding1.png",
              width: 283,
              height: 259,
            ),
            SizedBox(height: 27),
            Text(
              "WELCOME!",
              style: TextStyle(
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
                "Makeup has the power to transform your mood and empowers you to be a more confident person.",
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Color(0xff434C6D),
              ),
              onPressed: () {},
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
