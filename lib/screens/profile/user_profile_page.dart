import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isDarkMode = false;
  bool isLoggingOut = false;

  Future<void> logoutUser() async {
    try {
      setState(() => isLoggingOut = true);
      var mainStore = Provider.of<MainStore>(context, listen: false);
      await mainStore.audioPlayerStore.dispose();
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, '/');
      }
    } finally {
      setState(() => isLoggingOut = false);
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: context.theme.pageBackgroundColor,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: context.theme.mediumTextColor,
        ),
      ),
      title: Text(
        'Profile',
        style: TextStyle(color: context.theme.mediumTextColor),
      ),
    );
  }

  Widget _buildUserProfileAvatar() {
    return const CircleAvatar(
      radius: 80,
      backgroundImage: NetworkImage(
        'https://via.placeholder.com/250',
      ),
    );
  }

  Widget _buildUserProfileUsername() {
    return Text(
      'Hello, User',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: context.theme.mediumTextColor,
      ),
    );
  }

  Widget _buildDarkModeToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Dark Mode',
          style: TextStyle(
            fontSize: 18,
            color: context.theme.lightTextColor,
          ),
        ),
        const SizedBox(width: 10),
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            setState(() {
              isDarkMode = value;

              if (isDarkMode) {
                currentTheme = 'dark_theme';
              } else {
                currentTheme = 'light_theme';
              }

              ThemeProvider.controllerOf(context).setTheme(currentTheme!);
            });
          },
        ),
      ],
    );
  }

  _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: logoutUser,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Builder(builder: (context) {
            if (isLoggingOut) {
              return SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: context.theme.mediumTextColor,
                  strokeWidth: 2,
                ),
              );
            }

            return const Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = ThemeProvider.controllerOf(context).theme.id == 'dark_theme';

    return Scaffold(
      backgroundColor: context.theme.pageBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 60),
          _buildUserProfileAvatar(),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 50),
            child: _buildUserProfileUsername(),
          ),
          _buildDarkModeToggle(),
          _buildLogoutButton(),
        ],
      ),
    );
  }
}
