import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactService {
  static const String _contactUrl = "http://localhost:5000/api/contact";

  static Future<bool> submitContactForm({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_contactUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"name": name, "email": email, "message": message}),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        // You could log the error here: response.body
        print(response.body);
        return false;
      }
    } catch (e) {
      // Log exception
      print(e);
      return false;
    }
  }
}
