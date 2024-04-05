import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:theme_provider/theme_provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
  }

  void logoutUser() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: context.theme.pageBackgroundColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: context.theme.mediumTextColor,
        ),
        onPressed: () => Navigator.pop(context),
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
                ThemeProvider.controllerOf(context).setTheme('dark_theme');
              } else {
                ThemeProvider.controllerOf(context).setTheme('light_theme');
              }
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
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 18),
          ),
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
