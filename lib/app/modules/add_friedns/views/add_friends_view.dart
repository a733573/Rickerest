import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/modules/add_friedns/controllers/add_friends_controller.dart';
import 'package:rickerest/app/modules/add_friedns/views/widgets/find_account_text_field.dart';

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
