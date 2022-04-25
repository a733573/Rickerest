import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'home': 'Home',
          'friends': 'Friends',
          'chats': 'Chats',
          'settings': 'Settings',
          'general': 'General',
          'account': 'Account',
          'about': 'About Rickerest',
          'theme': 'Theme',
          'editProfile': 'Edit profile',
          'signOut': 'Sign out',
          'deleteAccount': 'Delete you account',
          'showLicenses': 'Show Licenses',
          'dark': 'Dark',
          'light': 'Light',
          'systemDefault': 'System default',
          'name': 'Name',
          'save': 'save',
          'addFriends': 'Add friends',
          'findByEmail': 'Find by Email',
          'textIsEmpty': 'Your name must be within 1-20 characters.',
          'invalidEmail': 'Not a valid Email.',
          'youCan\'tAddYourself': 'You can\'t add yourself to your friends.',
          'isAlreadyYourFriend': ' is already your friend.',
          'friendsIsEmpty':
              'Let\'s add a friend from the icon in the upper right corner!',
          'roomsIsEmpty':
              'Let\'s send a message to your friend from the icon in the upper right corner!',
        },
        'ja_JP': {
          'home': 'ホーム',
          'friends': 'フレンド',
          'chats': 'チャット',
          'settings': '設定',
          'general': '一般',
          'account': 'アカウント',
          'about': 'Rickerestについて',
          'theme': 'テーマ',
          'editProfile': 'プロフィール編集',
          'signOut': 'サインアウト',
          'deleteAccount': '退会',
          'showLicenses': 'ライセンスを表示する',
          'dark': 'ダーク',
          'light': 'ライト',
          'systemDefault': 'システムデフォルト',
          'name': '名前',
          'save': '保存',
          'addFriends': 'フレンド追加',
          'findByEmail': 'メールアドレスで探す',
          'textIsEmpty': '名前は1～20文字で入力してください。',
          'invalidEmail': '有効なメールアドレスではありません。',
          'youCan\'tAddYourself': '自分自身をフレンドに追加することはできません。',
          'isAlreadyYourFriend': 'は既にあなたのフレンドです。',
          'friendsIsEmpty': '右上のアイコンからフレンドを追加してみよう！',
          'roomsIsEmpty': '右上のアイコンから\nフレンドにメッセージを送ってみよう！',
        }
      };
}
