import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/cart_service.dart';
import '../../../services/auth_service.dart';

class CartSummary extends StatefulWidget {
  const CartSummary({super.key});

  @override
  State<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
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
    final cart = CartService();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sumário",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 24),


          _buildInputField(
            label: "Cupom de desconto",
            hintText: "Digite o cupom",
            controller: _couponController,
            onPressedOk: () {
              cart.applyCoupon(_couponController.text);
            },
          ),
          const SizedBox(height: 20),


          _buildInputField(
            label: "Frete",
            hintText: "Digite o CEP",
            controller: _shippingController,
            onPressedOk: () {
              if (_shippingController.text.isNotEmpty) {
                cart.setShippingCost(15.0);
              }
            },
          ),
          const SizedBox(height: 24),

          const Divider(color: Color(0xFF780BF7), thickness: 1),
          const SizedBox(height: 16),


          _buildSummaryRow(
            "${cart.itemCount.toString().padLeft(2, '0')} Produtos", 
            "R\$ ${cart.totalAmount.toStringAsFixed(2).replaceAll('.', ',')}"
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            "Frete", 
            "R\$ ${cart.shippingCost.toStringAsFixed(2).replaceAll('.', ',')}"
          ),
          if (cart.discount > 0) ...[
            const SizedBox(height: 16),
            _buildSummaryRow(
              "Desconto", 
              "- R\$ ${cart.discount.toStringAsFixed(2).replaceAll('.', ',')}",
              isGreen: true,
            ),
          ],
          const SizedBox(height: 16),

          const Divider(color: Color(0xFF780BF7), thickness: 1),
          const SizedBox(height: 16),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    color: Color(0xFF780BF7),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Total:",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF780BF7),
                    ),
                  ),
                ],
              ),
              Text(
                "R\$ ${cart.finalTotal.toStringAsFixed(2).replaceAll('.', ',')}",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF780BF7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),


          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Color(0xFF780BF7), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Continuar comprando",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF030303),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final authService = AuthService();
                final isLoggedIn = await authService.isLoggedIn();

                if (!context.mounted) return;

                if (!isLoggedIn) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        "Login Necessário",
                        style: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        "Você precisa estar logado para finalizar a compra.",
                        style: GoogleFonts.poppins(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancelar",
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Navigate to login page when implemented
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF780BF7),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            "Fazer Login",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pedido realizado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
                CartService().clearCart();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF780BF7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text(
                "Ir para pagamento",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required VoidCallback onPressedOk,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xFF1A1A1A).withValues(alpha: 0.5),
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.black, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Color(0xFF780BF7), width: 2),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 50,
              width: 70,
              child: ElevatedButton(
                onPressed: onPressedOk,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF780BF7),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Ok",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isGreen ? Colors.green : const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}
