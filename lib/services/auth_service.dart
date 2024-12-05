import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _loginUrl = 'http://192.168.1.8:3002/login';


  Future<String> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'userid': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        if (responseData.isNotEmpty) {
          // Login successful
          return 'success';
        } else {
          // Incorrect username or password
          return 'Invalid username or password';
        }
      } else {
        // Server-side error
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      // Network or other error
      return 'Network error: Failed to connect';
    }
  }
}
