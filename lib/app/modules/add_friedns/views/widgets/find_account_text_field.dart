import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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
              onChanged: (value) {
                AddFriendsController.to.textIsEmpty = value.isEmpty;
                AddFriendsController.to.validateText(value);
              },
              onSubmitted: (_) => AddFriendsController.to.findAccount(),
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Find by Email',
                errorText: AddFriendsController.to.errorText,
                suffixIcon: Visibility(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: !AddFriendsController.to.textIsEmpty,
                        maintainState: true,
                        maintainAnimation: true,
                        maintainSize: true,
                        child: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            AddFriendsController.to
                              ..textEditingController.clear()
                              ..textIsEmpty = true;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => AddFriendsController.to.findAccount(),
                      ),
                    ],
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
