import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/modules/home/controllers/add_friends_controller.dart';
import 'package:rickerest/app/modules/home/views/widgets/find_account_text_field.dart';

class AddFriendsView extends GetView<AddFriendsController> {
  const AddFriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add friends'),
      ),
      body: const FindAccountTextField(),
    );
  }
}
