import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/app_components.dart';
import '../../product/product.dart';
import '../../../services/product_service.dart';
import '../../../models/product.dart';

class CategoriesSection extends StatefulWidget {
  final String? searchQuery;
  const CategoriesSection({super.key, this.searchQuery});
  static const categories = [
    {'title': 'Roupas', 'img': 'assets/images/roupas.png'},
    {'title': 'Decoração', 'img': 'assets/images/hamburguer.png'},
    {'title': 'Canecas', 'img': 'assets/images/caneca_capy.png'},
    {'title': 'Acessórios', 'img': 'assets/images/teclado.png'},
  ];
  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final ProductService _productService = ProductService();
  late Future<List<ProductModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _productService.getProducts();
  }

  @override
  void didUpdateWidget(covariant CategoriesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _productsFuture = _productService.getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _sectionTitle("Categorias"),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "De roupas a gadgets tecnológicos temos tudo para atender suas paixões e hobbies com estilo e autenticidade.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B6B6B),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 35),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3,
            ),
            itemCount: CategoriesSection.categories.length,
            itemBuilder: (context, index) {
              final cat = CategoriesSection.categories[index];
              return CategoryCard(
                imageUrl: cat['img'] as String,
                title: cat['title'] as String,
                isDark: true,
                onTap: () {

                  final Map<String, String> categoryMapping = {
                    'Roupas': "men's clothing",
                    'Decoração': "jewelery",
                    'Canecas': "electronics",
                    'Acessórios': "women's clothing",
                  };
                  
                  final apiCategory = categoryMapping[cat['title']] ?? "men's clothing";
                  

                  setState(() {
                    _productsFuture = _productService.getProductsByCategory(apiCategory);
                  });
                },
              );
            },
          ),
          const SizedBox(height: 40),
          _sectionTitle("Promos especiais"),
          const SizedBox(height: 12),
          FutureBuilder<List<ProductModel>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(color: Color(0xFF780BF7)),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar produtos",
                    style: GoogleFonts.poppins(color: Colors.red),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Nenhum produto encontrado"));
              }

              final products = widget.searchQuery != null
                  ? snapshot.data!
                      .where((p) => p.title
                          .toLowerCase()
                          .contains(widget.searchQuery!.toLowerCase()))
                      .toList()
                  : snapshot.data!.take(6).toList();

              if (products.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Nenhum produto encontrado para sua busca"),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];
                  return CategoryCard(
                    imageUrl: p.image,
                    title: p.title,
                    price: p.price.toStringAsFixed(2).replaceAll('.', ','),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            product: p,
                            options: const {
                              "optionsLabel": "Tamanho disponível",
                              "choices": ["P", "M", "G"]
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Ver mais",
              style: GoogleFonts.poppins(
                color: const Color(0xFF780BF7),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF780BF7),
                decorationThickness: 2,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.orbitron(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
