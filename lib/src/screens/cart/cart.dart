import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/cart_service.dart';
import '../../widgets/navbar.dart';
import '../../widgets/footer.dart';
import 'widgets/cart_item_list.dart';
import 'widgets/cart_summary.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _couponController = TextEditingController();
  final TextEditingController _shippingController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    _shippingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Navbar(),
            Container(
              width: double.infinity,
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Banner_Mobile.png'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
                color: Color(0xFF0D0221),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_ios_sharp, size: 20, color: Colors.black),
                        const SizedBox(width: 12),
                        Text(
                          "Carrinho de Compras",
                          style: GoogleFonts.orbitron(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListenableBuilder(
                    listenable: CartService(),
                    builder: (context, child) {
                      final cart = CartService();
                      if (cart.items.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              const Icon(
                                Icons.shopping_cart_outlined,
                              size: 100,
                              color: Colors.grey
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Seu carrinho está vazio",
                                style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF780BF7),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Continuar Comprando"),
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF666666).withValues(alpha: 0.1),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: Color(0xFF666666),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Atenção, os produtos no carrinho não ficam reservados. Finalize a compra para garantir! :)",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF1A1A1A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          CartItemList(),
                          const SizedBox(height: 30),
                          CartSummary(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
