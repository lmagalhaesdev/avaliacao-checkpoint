import 'package:app/src/screens/home/widgets/categories_section.dart';
import 'package:app/src/screens/home/widgets/hero_section.dart';
import 'package:app/src/widgets/footer.dart';
import 'package:app/src/widgets/navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Navbar(
              onSearch: (value) {
                setState(() {
                  _searchQuery = value.isEmpty ? null : value;
                });
              },
            ),
            const HeroSection(),
            CategoriesSection(searchQuery: _searchQuery),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
