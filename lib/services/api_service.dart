import 'dart:convert';
import 'package:http/http.dart' as http;

class APIConfig {
  static const String baseUrl = "http://192.168.1.8:3000";
}

class APIService {
  /// ===============================
  /// REGISTER USER (AMANKAN json-server)
  /// ===============================
  Future<bool> registerUser(
    String name,
    String email,
    String password,
  ) async {
    final url = Uri.parse("${APIConfig.baseUrl}/users");

    final res = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    // json-server sukses = 201
    return res.statusCode == 201;
  }

  /// ===============================
  /// LOGIN USER (TETAP)
  /// ===============================
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

  /// ===============================
  /// GET PRODUCTS (TETAP)
  /// ===============================
  Future<List<dynamic>> getProducts() async {
    final url = Uri.parse("${APIConfig.baseUrl}/products");

    final res = await http.get(url);

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to fetch products");
    }
  }

  /// ===============================
/// CREATE ORDER (CHECKOUT / PAYMENT)
/// ===============================
Future<bool> createOrder(Map<String, dynamic> order) async {
  final url = Uri.parse("${APIConfig.baseUrl}/orders");

  final res = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(order),
  );

  return res.statusCode == 201;
}



/// ===============================
/// GET ORDERS BY USER
/// ===============================
Future<List<dynamic>> getOrders(String email) async {
  final url = Uri.parse(
    "${APIConfig.baseUrl}/orders?userEmail=$email",
  );

  final res = await http.get(url);

  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else {
    throw Exception("Failed to fetch orders");
  }
}

}
