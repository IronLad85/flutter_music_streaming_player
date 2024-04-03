import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_player/store/main_store.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<dynamic> authListener;
  late MainStore mainStore;

  @override
  void initState() {
    super.initState();
    mainStore = Provider.of<MainStore>(context, listen: false);
    authListener = FirebaseAuth.instance.authStateChanges().listen((user) {
      checkUserAuth(user);
    });
  }

  @override
  void dispose() {
    authListener.cancel();
    super.dispose();
  }

  Future<void> checkUserAuth(User? authData) async {
    try {
      if (authData != null) {
        // await mainStore.authStore.setUserAuthData(authData);
        navigateToHomeLayout();
      } else {
        navigateToLoginPage();
      }
    } catch (err) {
      navigateToLoginPage();
    }
  }

  void navigateToLoginPage() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void navigateToHomeLayout() {
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/app_logo.png',
            width: 300,
            height: 300,
          ),
        ],
      ),
    );
  }
}
