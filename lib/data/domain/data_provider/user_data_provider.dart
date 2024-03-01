import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<void> saveAuthState(bool authState) async {
    (await _sharedPreferences).setBool('isCompleted', authState);
  }
}
