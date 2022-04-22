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
              maxLength: 20,
              onChanged: (value) {
                controller
                  ..isChanged = controller.avatarImageByte.isNotEmpty ||
                      FirestoreService.to.currentUserModel!.name != value
                  ..textIsEmpty =
                      controller.textEditingController.value.text.isEmpty;
              },
              decoration: InputDecoration(
                suffixIcon: Obx(() {
                  return Visibility(
                    visible: !controller.textIsEmpty,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller
                          ..textEditingController.clear()
                          ..textIsEmpty = true;
                      },
                    ),
                  );
                }),
              ),
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
