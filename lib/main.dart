import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import SplashScreen
import 'homepage_screen.dart'; // Import HomePageScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi tema warna utama berdasarkan desain
    const Color primaryColor = Color(0xFF5E35B1); // Ungu gelap
    const Color secondaryColor = Color(0xFFE0F7FA); // Untuk highlight/latar terang

    return MaterialApp(
      title: 'SaveSmart App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          // Gaya teks untuk judul besar di HomePage
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          // Gaya teks untuk subjudul/informasi keuangan
          bodyMedium: TextStyle(color: Colors.black54),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // Halaman awal
        '/home': (context) => const HomePageScreen(), // Halaman utama
      },
      debugShowCheckedModeBanner: false,
    );
  }
}