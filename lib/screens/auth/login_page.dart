import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  AutovalidateMode _autoValidate = AutovalidateMode.onUserInteraction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildLogo(),
                  const SizedBox(height: 48.0),
                  _buildEmailField(),
                  const SizedBox(height: 24.0),
                  _buildPasswordField(),
                  const SizedBox(height: 12.0),
                  _buildLoginButton(),
                  _buildForgotPasswordLabel(),
                  _buildSignUpLabel()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/app_logo.png',
      fit: BoxFit.contain,
      height: 120.0,
    );
  }

  TextFormField _buildEmailField() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _email,
        validator: Validator.validateEmail,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email, color: Colors.grey),
          hintText: 'Email',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );

  TextFormField _buildPasswordField() => TextFormField(
        obscureText: true,
        controller: _password,
        validator: Validator.validatePassword,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: Colors.grey),
          hintText: 'Password',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );

  Padding _buildLoginButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () => _emailLogin(
            email: _email.text,
            password: _password.text,
            context: context,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text('SIGN IN', style: TextStyle(color: Colors.white)),
        ),
      );

  Widget _buildForgotPasswordLabel() => TextButton(
        onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
        child: const Text('Forgot password?',
            style: TextStyle(color: Colors.black54)),
      );

  Widget _buildSignUpLabel() => TextButton(
        child: const Text('Create an Account',
            style: TextStyle(color: Colors.black54)),
        onPressed: () => Navigator.pushNamed(context, '/signup'),
      );

  _changeLoadingVisible() {
    setState(() => _loadingVisible = !_loadingVisible);
  }

  Future<void> _emailLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeLoadingVisible();
        await Navigator.pushNamed(context, '/');
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        await _changeLoadingVisible();
        print("Sign In Error: $e");
      }
    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }
}
