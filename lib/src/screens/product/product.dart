import 'package:app/src/screens/product/widgets/product_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/src/widgets/footer.dart';
import 'package:app/src/widgets/navbar.dart';
import 'package:app/src/models/product.dart';

class ProductPage extends StatelessWidget {
  final ProductModel product;
  final Map<String, dynamic>? options;
  final Map<String, dynamic>? others;

  const ProductPage({
    super.key,
    required this.product,
    this.options,
    this.others,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.only(left: 16, top: 24),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back_ios_sharp, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      "Detalhes do Produto",
                      style: GoogleFonts.orbitron(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ProductSection(
              product: product,
              options: options,
              others: others,
            ),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
