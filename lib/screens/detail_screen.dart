import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class DetailScreen extends StatelessWidget {
  final dynamic product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // 🔹 BATASI LEBAR KONTEN DI DESKTOP
          final double maxWidth =
              constraints.maxWidth >= 900 ? 800 : double.infinity;

          return SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== IMAGE =====
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        constraints.maxWidth >= 900 ? 16 : 0,
                      ),
                      child: Image.asset(
                        "assets/${product["image"]}",
                        height: 260,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 260,
                          color: Colors.grey[300],
                          child:
                              const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),

                    // ===== CONTENT =====
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            product["description"],
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "Bahan-bahan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "Tepung terigu, mentega, gula, ragi, garam, air",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // ===== ADD TO CART =====
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<CartProvider>()
                                    .addToCart(product);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${product["name"]} ditambahkan ke keranjang",
                                    ),
                                    duration:
                                        const Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: const Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
