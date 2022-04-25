import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/modules/edit_profile/controllers/edit_profile_controller.dart';

import 'widgets/circle_avatar_edit_item.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('editProfile'.tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatarEditItem(),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('name'.tr),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              return TextField(
                controller: controller.textEditingController,
                maxLength: 20,
                onChanged: (value) {
                  controller
                    ..isChanged = controller.avatarImageByte.isNotEmpty ||
                        FirestoreService.to.currentUser!.name != value
                    ..validate(value);
                },
                decoration: InputDecoration(
                  errorText: controller.errorText.isNotEmpty
                      ? controller.errorText
                      : null,
                  suffixIcon: Visibility(
                    visible: !controller.textIsEmpty,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller
                          ..textEditingController.clear()
                          ..validate('');
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          Center(
            child: Obx(() {
              return ElevatedButton(
                onPressed: controller.isChanged && controller.errorText.isEmpty
                    ? () => EditProfileController.to.save()
                    : null,
                child: Text('save'.tr),
              );
            }),
          )
        ],
      ),
    );
  }
}
