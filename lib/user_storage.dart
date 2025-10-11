import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserStorage {
  static const String usersKey = 'users';
  static const String currentUserKey = 'current_user';

  // Daftar akun baru
  static Future<String> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList(usersKey) ?? [];

    // Cek apakah email sudah terdaftar
    for (var u in users) {
      final data = jsonDecode(u);
      if (data['email'] == email) {
        return 'Email sudah terdaftar';
      }
    }

    users.add(jsonEncode({'email': email, 'password': password}));
    await prefs.setStringList(usersKey, users);
    return 'Akun berhasil dibuat';
  }

  // Cek login
  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList(usersKey) ?? [];

    for (var u in users) {
      final data = jsonDecode(u);
      if (data['email'] == email && data['password'] == password) {
        // Simpan user yang sedang login
        await prefs.setString(currentUserKey, email);
        return true;
      }
    }
    return false;
  }

  // Ambil email user yang sedang login
  static Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(currentUserKey);
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(currentUserKey);
  }

  // Hapus semua data akun (opsional, misal untuk testing)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
