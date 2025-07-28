import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static const String _tokenKey = 'token';
  static const String _userKey = 'user';

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonUser = jsonEncode(user); // ✅ encode bien en JSON
    await prefs.setString(_userKey, jsonUser);
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString(_userKey);
    if (jsonUser != null) {
      try {
        return jsonDecode(jsonUser);
      } catch (e) {
        print('Erreur de parsing utilisateur : $e');
        await clearUser(); // Supprime les données invalides
      }
    }
    return null;
  }

  // Fonction pour supprimer toutes les données stockées
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
