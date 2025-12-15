import 'dart:convert';
import 'package:http/http.dart' as http;

class APIConfig {
  static const String baseUrl = "http://192.168.0.18:3000";
}




class APIService {
  /// REGISTER USER
  Future<dynamic> registerUser(String name, String email, String password) async {
    final url = Uri.parse("${APIConfig.baseUrl}/users");

    final body = {
      "name": name,
      "email": email,
      "password": password,
    };

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (res.statusCode == 201) {
      return jsonDecode(res.body);
    } else {
      return null;
    }
  }

  /// LOGIN USER
  Future<dynamic> loginUser(String email, String password) async {
    final url = Uri.parse(
      "${APIConfig.baseUrl}/users?email=$email&password=$password",
    );

    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data.isNotEmpty) return data[0];
      return null;
    } else {
      return null;
    }
  }

  /// GET PRODUCTS (FIXED)
  Future<List<dynamic>> getProducts() async {
    final url = Uri.parse("${APIConfig.baseUrl}/products");

    final res = await http.get(url);

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to fetch products");
    }
  }
}
