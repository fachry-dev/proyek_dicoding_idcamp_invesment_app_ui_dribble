import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Fungsi untuk navigasi setelah delay
  void _navigateToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Panggil navigasi segera setelah widget dibangun
    _navigateToHome(context);

    // Dapatkan warna primer dari tema
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: primaryColor, // Latar belakang ungu gelap
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Icon atau Ilustrasi utama
            const Icon(
              Icons.savings,
              size: 100.0,
              color: Colors.white,
            ),
            const SizedBox(height: 20.0),
            // Teks judul aplikasi
            Text(
              'SaveSmart',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 40,
                  ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Empowering You with Smart Saving Strategies',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40.0),
            // Indikator loading
            CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.white.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}