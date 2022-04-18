import 'package:flutter/material.dart';
import 'package:rickerest/app/modules/home/controllers/home_controller.dart';

class FindAccountTextField extends StatelessWidget {
  const FindAccountTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: controller,
            onSubmitted: HomeController.to.findAccount,
            decoration: InputDecoration(
              labelText: 'Find by email',
              suffixIcon: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => controller.clear(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () =>
                          HomeController.to.findAccount(controller.text),
                    ),
                  ],
                ),
              ),
              alignLabelWithHint: true,
            ),
          ),
        ),
      ],
    );
  }
}
