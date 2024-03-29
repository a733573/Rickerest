import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/modules/edit_profile/controllers/edit_profile_controller.dart';

class CropImageDialog extends StatelessWidget {
  CropImageDialog(this.imageBytes, {Key? key}) : super(key: key);
  final Uint8List imageBytes;
  final cropController = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () => cropController.crop(),
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Crop(
        image: imageBytes,
        controller: cropController,
        aspectRatio: 1,
        withCircleUi: true,
        baseColor: Colors.black,
        onCropped: (data) {
          EditProfileController.to.avatarImageByte = data;
          EditProfileController.to.isChanged = true;
          Get.back();
        },
      ),
    );
  }
}
