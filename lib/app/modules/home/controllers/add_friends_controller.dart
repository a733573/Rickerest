import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddFriendsController extends GetxController {
  static AddFriendsController get to => Get.find();

  final textEditingController = TextEditingController();

  final RxString _errorText = ''.obs;

  String? get errorText {
    if (_errorText.value.isEmpty) {
      return null;
    }
    return _errorText.value;
  }

  void emailValidate(String email) {
    _errorText.value = (email.isEmpty || EmailValidator.validate(email))
        ? ''
        : 'Not a valid Email.';
  }
}
