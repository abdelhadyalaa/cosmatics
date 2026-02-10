import 'package:flutter/material.dart';

class AppCountryCode extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const AppCountryCode({super.key, this.onChanged});

  @override
  State<AppCountryCode> createState() => _AppCountryCodeState();
}

class _AppCountryCodeState extends State<AppCountryCode> {
  late int selectedCountryCode;

  final list = [20, 966, 971, 965];

  @override
  void initState() {
    super.initState();
    selectedCountryCode = list.first;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onChanged != null) {
        widget.onChanged!("+$selectedCountryCode");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            icon: const Padding(
              padding: EdgeInsetsDirectional.only(start: 8.0),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            value: selectedCountryCode,
            items: list
                .map((e) => DropdownMenuItem(value: e, child: Text("+$e")))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedCountryCode = value;
                });

                if (widget.onChanged != null) {
                  widget.onChanged!("+$value");
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
