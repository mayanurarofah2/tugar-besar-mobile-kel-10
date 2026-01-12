import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import 'order_screen.dart'; // ✅ TAMBAHAN

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String paymentMethod = "COD";
  bool isLoading = false;

  Future<void> handlePayment() async {
    final cart = context.read<CartProvider>();
    final auth = context.read<AuthProvider>();

    setState(() => isLoading = true);

    final order = {
      "userEmail": auth.user?["email"],
      "items": cart.cart
          .map((e) => {
                "name": e.name,
                "qty": e.qty,
                "price": e.price,
              })
          .toList(),
      "total": cart.totalPrice,
      "paymentMethod": paymentMethod,
      "status": "PAID",
      "createdAt": DateTime.now().toIso8601String(),
    };

    final success = await APIService().createOrder(order);

    setState(() => isLoading = false);

    if (success) {
      cart.clearCart();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OrderScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Metode Pembayaran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            RadioListTile(
              title: const Text("COD (Bayar di Tempat)"),
              value: "COD",
              groupValue: paymentMethod,
              onChanged: (v) => setState(() => paymentMethod = v!),
            ),

            RadioListTile(
              title: const Text("Transfer Bank"),
              value: "TRANSFER",
              groupValue: paymentMethod,
              onChanged: (v) => setState(() => paymentMethod = v!),
            ),

            const Spacer(),

            Text(
              "Total: Rp ${cart.totalPrice}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : handlePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Bayar Sekarang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
