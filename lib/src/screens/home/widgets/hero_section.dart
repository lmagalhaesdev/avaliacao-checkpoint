import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Banner_Mobile.png'),
          fit: .cover,
        ),
      ),
      child: Column(
        spacing: 20,
        crossAxisAlignment: .center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset('assets/images/img_hero_mob.png', width: 300),
          ),
          Text.rich(
            textAlign: .center,
            style: TextStyle(
              fontFamily: GoogleFonts.orbitron().fontFamily,
              fontSize: 50,
              fontWeight: .bold,
            ),
            TextSpan(
              text: 'Hora de abraçar seu ',
              style: TextStyle(color: Color(0xFFFF55DF)),
              children: [
                TextSpan(
                  text: 'lado geek',
                  style: TextStyle(color: Color(0xFF8FFF24)),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF780BF7),
              padding: .symmetric(horizontal: 30, vertical: 25),
            ),
            child: Text(
              'Ver as Novidades',
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 25,
                color: Colors.white,
                fontWeight: .bold,
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}