import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchbar extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  const Searchbar({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onSubmitted: onSearch,
        style: GoogleFonts.poppins(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'O que você procura?',
          hintStyle: GoogleFonts.poppins(color: Colors.black54),
          suffixIcon: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.search,
              color: Color(0xFF780BF7),
            ),
          ),
          filled: true,
          fillColor: const Color(0xFFF1F1F1),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFF780BF7), width: 2),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
