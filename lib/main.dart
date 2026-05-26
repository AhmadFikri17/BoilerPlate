// Gunakan kata kunci 'hide AuthProvider' agar Flutter mengabaikan AuthProvider milik Firebase
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider; 

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/temperature/konversi_suhu_page.dart';
import 'presentation/providers/auth_provider.dart'; // Ini AuthProvider Anda yang asli
import 'presentation/providers/suhu_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<SuhuProvider>(
          create: (_) => SuhuProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Konversi Suhu',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Pengganti primarySwatch di Material 3
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              backgroundColor: Colors.blue, // Warna default tombol login
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),

        // === 3. UPDATE BAGIAN HOME MENGGUNAKAN STREAMBUILDER ===
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Jika Firebase sedang mengecek status sesi login di awal aplikasi dibuka
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Jika ada data user (artinya user sudah login) -> Langsung masuk ke halaman utama
            if (snapshot.hasData) {
              return const KonversiSuhuPage();
            }

            // Jika data user null (artinya user belum login / baru saja logout) -> Arahkan ke halaman login
            return const LoginPage();
          },
        ),
      ),
    );
  }
}