import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/views/auth/create_account.dart';
import 'package:cosmetics_app/views/auth/login.dart';
import 'package:flutter/material.dart';

class AppLoginOrRegister extends StatelessWidget {
  final bool isLogin;

  const AppLoginOrRegister({super.key, this.isLogin = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: isLogin ? "Don’t have an account?" : "Have an account?",
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: TextButton(
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                ),
                onPressed: () {
                  goTo(page: CreateAccountView());
                },
                child: Text(isLogin ? "Register" : "Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
