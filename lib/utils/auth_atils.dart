import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static AuthUtils instance = AuthUtils();
  String tokenLocal = "";

  void setTokenLocal(String token) {
    tokenLocal = token;
  }

  String getTokenLocal() {
    return tokenLocal;
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("Token");
  }

  Future getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("UserId");
  }

  Future getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("Full Name");
  }

  Future<bool> saveTokenPrefs(
    String token,
    String userId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Token", token);
    prefs.setString("userId", userId);
    setTokenLocal(token);
    return false;
  }

  Future<void> clearAllData() async {
    setTokenLocal("");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
