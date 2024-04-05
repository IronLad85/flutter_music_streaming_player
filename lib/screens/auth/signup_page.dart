import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:music_player/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  InputDecoration _inputDecoration(IconData icon, String hintText) {
    return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Icon(icon, color: Colors.grey),
      ),
      hintText: hintText,
      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    );
  }

  void _changeLoadingVisible() {
    setState(() => _isLoading = !_isLoading);
  }

  Future<void> _emailSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        _changeLoadingVisible();
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/');
        }
      } catch (e) {
        print("Sign Up Error: $e");
      }
    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
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

  Widget _buildSignInLabel() {
    return TextButton(
      onPressed: Navigator.of(context).pop,
      child: Text(
        'Have an Account? Sign In.',
        style: TextStyle(
          color: context.theme.mediumTextColor,
          fontSize: 16,
        ),
      ),
    );
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

  Widget _buildFullNameField() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: TextFormField(
        autofocus: false,
        textCapitalization: TextCapitalization.words,
        controller: _fullNameController,
        validator: Validator.validateName,
        style: TextStyle(
          color: context.theme.mediumTextColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: _inputDecoration(Icons.person, 'Full Name'),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: _emailController,
        style: TextStyle(
          color: context.theme.mediumTextColor,
          fontWeight: FontWeight.w500,
        ),
        validator: Validator.validateEmail,
        decoration: _inputDecoration(Icons.email, 'Email'),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: TextFormField(
        obscureText: true,
        controller: _passwordController,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: context.theme.mediumTextColor,
        ),
        validator: Validator.validatePassword,
        decoration: _inputDecoration(Icons.lock, 'Password'),
      ),
    );
  }

  Container _buildSignUpButton() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(12),
        ),
        onPressed: _emailSignUp,
        child: const SizedBox(
          width: 150,
          child: Center(
            child: Text(
              'SIGN UP',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.pageBackgroundColor,
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildFullNameField(),
                _buildEmailField(),
                _buildPasswordField(),
                _buildSignUpButton(),
                _buildSignInLabel()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
