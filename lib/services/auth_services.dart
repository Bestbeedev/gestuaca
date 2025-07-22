import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  //Local Host --phone
  //static const String baseUrl = 'http://10.227.138.210:8000/api';

  //Host at home
  static const String baseUrl = 'http://192.168.100.7:8000/api';

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'],
          'user': responseData['user'],
          'token': responseData['token'] ?? '',
        };
      } else if (response.statusCode == 422) {
        final errors =
            responseData['errors']?['email']?[0] ?? 'Email déjà utilisé';
        return {'success': false, 'message': errors};
      } else {
        return {'success': false, 'message': ' Erreur serveur'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erreur de connexion $e'};
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Utilisation de http.post avec des paramètres de formulaire
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },

        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseData = json.decode(response.body);

      print(responseData);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'],
          'user': responseData['user'],
          'token': responseData['token'] ?? '',
        };
      } else if (response.statusCode == 401) {
        return {
          'success': false,
          'message':
              responseData['message'] ?? 'Email ou mot de passe incorrect',
        };
      } else {
        return {'success': false, 'message': 'Erreur interne serveur'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erreur de connexion $e'};
    }
  }
}

// 'success' => true,
// 'message' => 'Connexion réussie',
// 'user'    => $user,
// 'token'   => $token,
