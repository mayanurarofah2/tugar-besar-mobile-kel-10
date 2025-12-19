import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback onBackToHome;

  const CartScreen({super.key, required this.onBackToHome});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBackToHome,
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // 🔹 BATAS LEBAR (DESKTOP)
          final double maxWidth =
              constraints.maxWidth >= 900 ? 700 : double.infinity;

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                children: [
                  // ===== LIST CART =====
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.cart.length,
                      itemBuilder: (context, index) {
                        final item = cart.cart[index];

                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),

                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/${item.image}",
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                            ),
                          ),

                          title: Text(item.name),
                          subtitle: Text("${item.qty} pcs"),

                          trailing: SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end,
                              children: [
                                Text("Rp ${item.price}"),
                                const SizedBox(height: 4),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          cart.increaseQty(item),
                                      child: const Icon(
                                        Icons.add_circle,
                                        size: 24,
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    Text(
                                      "${item.qty}",
                                      style: const TextStyle(
                                          fontSize: 16),
                                    ),

                                    const SizedBox(width: 8),

                                    GestureDetector(
                                      onTap: () =>
                                          cart.decreaseQty(item),
                                      child: const Icon(
                                        Icons.remove_circle,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // ===== FOOTER =====
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Produk"),
                            Text("Rp ${cart.totalPrice}"),
                          ],
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding:
                                  const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Checkout"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
