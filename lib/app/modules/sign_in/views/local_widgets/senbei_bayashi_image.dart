import 'package:flutter/material.dart';

class SenbeiBayashiImage extends StatelessWidget {
  const SenbeiBayashiImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset(
        'assets/icon/senbei_bayashi_icon.png',
      ),
    );
  }
}
