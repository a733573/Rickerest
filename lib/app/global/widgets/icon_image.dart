import 'package:flutter/material.dart';

class IconImage extends StatelessWidget {
  const IconImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(maxHeight: 500),
      child: Image.asset('images/icon.png'),
    );
  }
}
