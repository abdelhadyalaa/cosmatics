import 'package:flutter/material.dart';

import 'app_input.dart';

class AppSearch extends StatelessWidget {
  const AppSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return AppInput(label: "Search", suffixIcon: "search.svg", isSearch: true);
  }
}
