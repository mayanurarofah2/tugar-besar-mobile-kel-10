import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<dynamic> products = [];
  bool isLoading = false;

  // ✅ TAMBAHAN: penanda sudah load
  bool hasLoaded = false;

  Future<void> fetchProducts() async {
    // ✅ TAMBAHAN: cegah fetch berulang
    if (isLoading || hasLoaded) return;

    isLoading = true;
    notifyListeners();

    try {
      products = await APIService()
          .getProducts()
          .timeout(const Duration(seconds: 10)); // ✅ TAMBAHAN
      hasLoaded = true; // ✅ TAMBAHAN
    } catch (e) {
      debugPrint("Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
