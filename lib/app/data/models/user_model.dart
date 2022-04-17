class UserModel {
  UserModel(this._uid, Map<String, dynamic> data) {
    _name = data['name'] as String;
    _email = data['email'] as String;
    final avatarImageUrl = data['avatarImageUrl'] as String;
    if (avatarImageUrl.isEmpty) {
      _avatarImageUrl = avatarImageUrl;
    }
    _friends = data['friends'] as Map<String, dynamic>;
  }

  final String _uid;
  late String _name;
  late final String _email;
  String _avatarImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/rickerest.appspot.com/o/default_profile_image.png?alt=media&token=372ebb78-6004-4850-ae9e-52f4b7b09cb8';
  late final Map<String, dynamic> _friends;

  String get uid => _uid;

  String get name => _name;

  String get email => _email;

  String get avatarImageUrl => _avatarImageUrl;

  Map<String, dynamic> get friends => _friends;
}
