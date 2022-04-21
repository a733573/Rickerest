import 'package:flutter/material.dart';

class AvatarImageDialog extends StatelessWidget {
  const AvatarImageDialog(this.avatarImageUrl, {Key? key}) : super(key: key);
  final String avatarImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.white,
              child: Image.network(
                avatarImageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
