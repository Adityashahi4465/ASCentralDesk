import 'global.dart';

class LocalDB {
  static Future<String?> getUrl() async {
    return await sharedPreferences!.getString('photoUrl');
  }

  static Future<String?> getName() async {
    return await sharedPreferences!.getString('name');
  }

  static Future<String?> getemail() async {
    return await sharedPreferences!.getString('email');
  }
}
