import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/app_components.dart';
import '../../../services/cart_service.dart';
import '../../../models/product.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({
    super.key,
    required this.product,
    this.options,
    this.others,
  });

  final ProductModel product;
  final Map<String, dynamic>? options;
  final Map<String, dynamic>? others;

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  String? _selectedOption;
  String _selectedQuantity = '1';
  String? _selectedOther;

  @override
  void initState() {
    super.initState();

    if (widget.options != null && widget.options!['choices'] != null) {
      final choices = widget.options!['choices'] as List<dynamic>;
      if (choices.isNotEmpty) {
        _selectedOption = choices[0].toString();
      }
    }

    if (widget.others != null && widget.others!.isNotEmpty) {
      final firstKey = widget.others!.keys.first;
      final choices = widget.others![firstKey] as List<dynamic>;
      if (choices.isNotEmpty) {
        _selectedOther = choices[0].toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0D0221),
              image: DecorationImage(
                image: AssetImage('assets/images/Banner_Mobile.png'),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
            child: widget.product.image.startsWith('http')
                ? Image.network(
              widget.product.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 100, color: Colors.white),
            )
                : const Icon(Icons.image, size: 100, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            widget.product.title,
            style: GoogleFonts.orbitron(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Wrap(
            spacing: 20,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            children: [
              Icon(Icons.share, size: 30, color: Colors.black),
              Icon(Icons.favorite_border, size: 30, color: Colors.black),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            widget.product.description,
            style: GoogleFonts.poppins(fontSize: 20),
          ),
          const SizedBox(height: 15),
          Text(
            "R\$ ${widget.product.price.toStringAsFixed(2).replaceAll('.', ',')}",
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          if (widget.options != null) ...[
            const SizedBox(height: 25),
            Text(
              widget.options!['optionsLabel'] ?? 'Escolha uma opção',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: (widget.options!['choices'] as List<dynamic>).map((choice) {
                final choiceString = choice.toString();
                return Row(
                  children: [
                    Radio<String>(
                      value: choiceString,
                      groupValue: _selectedOption,
                      toggleable: true,
                      activeColor: Colors.black,
                      fillColor: WidgetStateProperty.all(Colors.black),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                    Text(
                      choiceString,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 10),
          CustomSelect(
            label: "Quantidade",
            items: List.generate(10, (index) => (index + 1).toString()),
            value: _selectedQuantity,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedQuantity = value;
                });
              }
            },
          ),
          const SizedBox(height: 20),
          if (widget.others != null && widget.others!.isNotEmpty)
            CustomSelect(
              label: widget.others!.keys.first,
              items: (widget.others!.values.first as List)
                  .map((e) => e.toString())
                  .toList(),
              value: _selectedOther,
              onChanged: (value) {
                setState(() {
                  _selectedOther = value;
                });
              },
            ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                final quantity = int.parse(_selectedQuantity);
                CartService().addToCart(
                  widget.product,
                  quantity: quantity,
                  size: _selectedOption ?? 'M',
                );

                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Produto adicionado ao carrinho!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                overlayColor: const Color(0xFF430091),
                backgroundColor: const Color(0xFF780BF7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.add_shopping_cart,
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Adicionar ao carrinho",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}