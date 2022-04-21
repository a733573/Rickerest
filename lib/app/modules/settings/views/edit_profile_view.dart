import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rickerest/app/modules/settings/controllers/edit_profile_controller.dart';

import 'widgets/crop_image_dialog.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
      ),
      body: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                final imageBytes = await image!.readAsBytes();
                await Get.to(
                  () => CropImageDialog(imageBytes),
                  fullscreenDialog: true,
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade600,
                      BlendMode.modulate,
                    ),
                    child: Obx(() {
                      return CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          controller.avatarImageUrl,
                        ),
                        backgroundColor: Colors.white,
                      );
                    }),
                  ),
                  const Icon(
                    Icons.camera_enhance_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
