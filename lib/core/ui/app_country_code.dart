import 'package:flutter/material.dart';

class AppCountryCode extends StatefulWidget {
  const AppCountryCode({super.key});

  @override
  State<AppCountryCode> createState() => _AppCountryCodeState();
}

class _AppCountryCodeState extends State<AppCountryCode> {
  late int selectedCountryCode;

  final list = [10, 20, 30, 40, 50];

  @override
  void initState() {
    super.initState();
    selectedCountryCode = list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(
              context,
            ).inputDecorationTheme.enabledBorder!.borderSide.color,
          ),
        ),
        child: DropdownButton<int>(
          icon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: Icon(Icons.keyboard_arrow_down),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
          value: selectedCountryCode,
          items: list
              .map((e) => DropdownMenuItem(value: e, child: Text("$e")))
              .toList(),
          onChanged: (value) {
            selectedCountryCode = value!;
            setState(() {});
          },
        ),
      ),
    );
  }
}
