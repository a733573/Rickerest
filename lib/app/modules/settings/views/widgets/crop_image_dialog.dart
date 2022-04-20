import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/services/storage_service.dart';

class CropImageDialog extends StatelessWidget {
  CropImageDialog(this.imageBytes, {Key? key}) : super(key: key);
  final Uint8List imageBytes;
  final cropController = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
        onCropped: (data) async {
          try {
            await StorageService.to.uploadAvatarImage(data);
            Get
              ..back()
              ..snackbar('Success!', 'Uploaded your avatar image.');
          } on Exception catch (_) {
            Get
              ..back()
              ..snackbar('Error!', 'Failed to upload your avatar image.');
          }
        },
      ),
    );
  }
}
