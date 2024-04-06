import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/services/auth_service.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:music_player/utils/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _loadingVisible = false;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final String _loginErrorMessage = 'Error occured while trying to login';

  void _changeLoadingVisible() {
    setState(() => _loadingVisible = !_loadingVisible);
  }

  void _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: Navigator.of(context).pop,
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        _changeLoadingVisible();
        FocusScope.of(context).unfocus();
        await AuthService().signInWithEmailAndPassword(email, password);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } on FirebaseAuthException catch (exception) {
        _showSnackBar(exception.message ?? _loginErrorMessage);
      } catch (e) {
        _showSnackBar(_loginErrorMessage);
      } finally {
        _changeLoadingVisible();
      }
    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }

  Widget _buildLogo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 48),
      child: Image.asset(
        'assets/app_logo.png',
        fit: BoxFit.contain,
        height: 120.0,
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: TextFormField(
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        validator: Validator.validateEmail,
        style: TextStyle(
          color: context.theme.mediumTextColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          prefixIcon: Icon(Icons.email, color: context.theme.lightTextColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: TextFormField(
        obscureText: true,
        controller: _password,
        validator: Validator.validatePassword,
        style: TextStyle(
          color: context.theme.mediumTextColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          prefixIcon: Icon(Icons.lock, color: context.theme.lightTextColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        onPressed: () => _loginUser(
          context: context,
          email: _email.text,
          password: _password.text,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: SizedBox(
          width: 150,
          child: Center(
            child: Builder(builder: (context) {
              if (_loadingVisible) {
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
                'LOGIN',
                style: TextStyle(color: Colors.white, fontSize: 16),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLabel() {
    return TextButton(
      child: Text(
        'Create an Account',
        style: TextStyle(
          fontSize: 16,
          color: context.theme.lightTextColor,
        ),
      ),
      onPressed: () => Navigator.pushNamed(context, '/signup'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.pageBackgroundColor,
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              _buildEmailField(),
              _buildPasswordField(),
              _buildLoginButton(),
              _buildSignUpLabel()
            ],
          ),
        ),
      ),
    );
  }
}
