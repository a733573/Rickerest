import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

class CurrentUserTile extends StatelessWidget {
  const CurrentUserTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirestoreService.to.currentUserStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // if (snapshot.hasError) {
        //   return const SizedBox();
        // }
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const SizedBox();
        // }

        final data = snapshot.data?.data()! as Map<String, dynamic>?;
        final name = data?['name'] as String?;
        final avatarImageUrl = data?['avatarImageUrl'] as String?;

        return GFListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              name ?? '',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          avatar: GFAvatar(
            size: GFSize.LARGE,
            backgroundImage: avatarImageUrl != null
                ? NetworkImage(avatarImageUrl)
                : Image.asset('assets/images/default_profile_image.png').image,
          ),
        );
      },
    );
  }
}
