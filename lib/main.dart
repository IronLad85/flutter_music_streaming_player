import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_player/screens/auth/login_page.dart';
import 'package:music_player/screens/auth/signup_page.dart';
import 'package:music_player/screens/home_layout/home_layout.dart';
import 'package:music_player/screens/splash_page.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (_) => const SplashScreen(),
  '/login': (_) => const LoginPage(),
  '/home': (_) => const HomeLayout(),
  '/signup': (_) => const SignUpPage(),
};

Future<void> initPrerequisites() async {
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
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
    var brightness = MediaQuery.of(context).platformBrightness;
    String themeName =
        brightness == Brightness.dark ? 'dark_theme' : 'light_theme';

    return Provider<MainStore>(
      create: (_) => MainStore(),
      child: ThemeProvider(
        defaultThemeId: currentTheme ?? themeName,
        themes: appThemes,
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp(
              title: 'Music Player',
              routes: routes,
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.themeOf(themeContext).data,
            ),
          ),
        ),
      ),
    );
  }
}
