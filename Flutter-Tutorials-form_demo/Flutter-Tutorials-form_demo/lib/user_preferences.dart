import 'package:shared_preferences/shared_preferences.dart';
import 'package:profile_page/user.dart';

class UserPreferences {
  static const _keyUser = 'user';

  static Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyUser);
    if (json == null) {
      return User(
        name: '',
        age: 0,
        gender: '',
        country: '',
        hobbies: [],
      );
    }
    return User.fromJson(Map<String, dynamic>.from(jsonDecode(json)));
  }

  static Future<bool> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(user.toJson());
    return prefs.setString(_keyUser, json);
  }
}
