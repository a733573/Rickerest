import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rickerest/app/global/controllers/user_controller.dart';

class GetUserName extends StatelessWidget {
  GetUserName({Key? key}) : super(key: key);

  final String documentId = UserController.to.uid;

  @override
  Widget build(BuildContext context) {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text('Document does not exist');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Name: ${data['name']}");
        }

        return const Text('loading');
      },
    );
  }
}
