import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_player/screens/auth/login_page.dart';
import 'package:music_player/screens/home_layout/home_layout.dart';
import 'package:music_player/screens/splash_page.dart';
import 'package:music_player/store/main_store.dart';
import 'package:provider/provider.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (_) => const SplashScreen(),
  '/login': (_) => const LoginPage(),
  '/home': (_) => const HomeLayout(),
};

Future<void> initPrerequisites() async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPrerequisites();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<MainStore>(
      create: (_) => MainStore(),
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
