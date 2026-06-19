import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'screens/root_nav.dart';

void main() {
  runApp(const TastyBitesApp());
}

class TastyBitesApp extends StatelessWidget {
  const TastyBitesApp({super.key});

  static const Color seed = Color(0xFFFF6B35);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        title: 'Tasty Bites',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: seed,
            primary: seed,
          ),
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: Color(0xFF1A1A1A),
          ),
        ),
        home: const RootNav(),
      ),
    );
  }
}
