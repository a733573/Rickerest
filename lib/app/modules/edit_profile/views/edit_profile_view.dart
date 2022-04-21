import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        children: const [
          CircleAvatarEditItem(),
        ],
      ),
    );
  }
}
