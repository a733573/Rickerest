import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/create_room_controller.dart';

class CreateRoomView extends GetView<CreateRoomController> {
  const CreateRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CreateRoomView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CreateRoomView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
