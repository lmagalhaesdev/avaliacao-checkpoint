import 'package:app/src/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/cart/cart.dart';
import '../services/cart_service.dart';

class Navbar extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  const Navbar({super.key, this.onSearch});

  static const double _iconSize = 32.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 40, bottom: 10, left: 8, right: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "UseDev",
                style: GoogleFonts.orbitron(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: _iconSize,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_outline,
                          size: _iconSize,
                          color: Colors.black,
                        ),
                      ),
                      ListenableBuilder(
                        listenable: CartService(),
                        builder: (context, child) {
                          final count = CartService().itemCount;
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: _iconSize,
                                  color: Colors.black,
                                ),
                              ),
                              if (count > 0)
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF55DF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '$count',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Searchbar(onSearch: onSearch),
      ],
    );
  }
}
