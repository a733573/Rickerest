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
        title: const Text('Edit profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatarEditItem(),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('Name'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: controller.textEditingController,
              onChanged: (value) {
                controller.isChanged = controller.avatarImageByte.isNotEmpty ||
                    FirestoreService.to.currentUserModel!.name != value;
              },
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Obx(() {
              return ElevatedButton(
                onPressed: controller.isChanged
                    ? () => EditProfileController.to.save()
                    : null,
                child: const Text('save'),
              );
            }),
          )
        ],
      ),
    );
  }
}
