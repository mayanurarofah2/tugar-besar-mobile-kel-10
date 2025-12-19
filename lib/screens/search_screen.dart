import 'package:flutter/material.dart';
import '../models/product.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const SearchScreen({super.key, this.onBackToHome});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  final List<Product> products = [
    Product(id: 1, name: "Chocolate Cake", price: 20000, image: "cake1.png"),
    Product(id: 2, name: "Vanilla Cake", price: 20000, image: "va.png"),
    Product(id: 3, name: "Strawberry Cake", price: 25000, image: "ca3.png"),
    Product(id: 4, name: "Carrot Cake", price: 20000, image: "ca2.png"),
    Product(id: 5, name: "Red Velvet Cake", price: 30000, image: "ca1.png"),
    Product(id: 6, name: "Lemon Cake", price: 30000, image: "ca4.png"),
  ];

  @override
  Widget build(BuildContext context) {
    final results = products
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.onBackToHome != null) {
              widget.onBackToHome!();
            }
          },
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // 🔹 RESPONSIVE GRID
          int crossAxisCount = 2;

          if (constraints.maxWidth >= 1200) {
            crossAxisCount = 5; // desktop besar
          } else if (constraints.maxWidth >= 900) {
            crossAxisCount = 4; // desktop
          } else if (constraints.maxWidth >= 600) {
            crossAxisCount = 3; // tablet
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ===== SEARCH FIELD =====
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    onChanged: (value) =>
                        setState(() => query = value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Cakes",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ===== RESULT GRID =====
                Expanded(
                  child: GridView.builder(
                    itemCount: results.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      final p = results[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                product: {
                                  "id": p.id,
                                  "name": p.name,
                                  "price": p.price,
                                  "image": p.image,
                                  "description":
                                      "Deskripsi belum tersedia",
                                },
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/${p.image}",
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              p.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Rp ${p.price}"),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
