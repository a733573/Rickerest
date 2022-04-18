import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rickerest/app/modules/home/controllers/home_controller.dart';

import '../../controllers/add_friends_controller.dart';

class FindAccountTextField extends StatelessWidget {
  const FindAccountTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(() {
            return TextField(
              controller: AddFriendsController.to.textEditingController,
              onChanged: AddFriendsController.to.emailValidate,
              onSubmitted: (email) => HomeController.to.findAccount(email),
              decoration: InputDecoration(
                labelText: 'Find by Email',
                errorText: AddFriendsController.to.errorText,
                suffixIcon: Visibility(
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        Visibility(
                          visible: AddFriendsController
                              .to.textEditingController.value.text.isNotEmpty,
                          maintainState: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          child: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => AddFriendsController.to
                              ..textEditingController.clear()
                              ..emailValidate(''),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => HomeController.to.findAccount(
                            AddFriendsController.to.textEditingController.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                alignLabelWithHint: true,
              ),
            );
          }),
        ),
      ],
    );
  }
}
