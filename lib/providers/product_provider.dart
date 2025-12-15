import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<dynamic> products = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      products = await APIService().getProducts();
    } catch (e) {
      debugPrint("Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
