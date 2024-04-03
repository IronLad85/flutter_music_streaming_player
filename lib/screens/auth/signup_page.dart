import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AutovalidateMode _autoValidate = AutovalidateMode.onUserInteraction;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              const SizedBox(height: 48.0),
              _buildFirstNameField(),
              const SizedBox(height: 24.0),
              _buildLastNameField(),
              const SizedBox(height: 24.0),
              _buildEmailField(),
              const SizedBox(height: 24.0),
              _buildPasswordField(),
              const SizedBox(height: 12.0),
              _buildSignUpButton(),
              _buildSignInLabel()
            ],
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

  TextFormField _buildFirstNameField() => TextFormField(
        autofocus: false,
        textCapitalization: TextCapitalization.words,
        controller: _firstNameController,
        validator: Validator.validateName,
        decoration: _inputDecoration(Icons.person, 'First Name'),
      );

  TextFormField _buildLastNameField() => TextFormField(
        autofocus: false,
        textCapitalization: TextCapitalization.words,
        controller: _lastNameController,
        validator: Validator.validateName,
        decoration: _inputDecoration(Icons.person, 'Last Name'),
      );

  TextFormField _buildEmailField() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: _emailController,
        validator: Validator.validateEmail,
        decoration: _inputDecoration(Icons.email, 'Email'),
      );

  TextFormField _buildPasswordField() => TextFormField(
        obscureText: true,
        controller: _passwordController,
        validator: Validator.validatePassword,
        decoration: _inputDecoration(Icons.lock, 'Password'),
      );

  Padding _buildSignUpButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(12),
          ),
          onPressed: _emailSignUp,
          child: const Text('SIGN UP', style: TextStyle(color: Colors.white)),
        ),
      );

  Widget _buildSignInLabel() => TextButton(
        child: const Text('Have an Account? Sign In.',
            style: TextStyle(color: Colors.black54)),
        onPressed: () => Navigator.pushNamed(context, '/signin'),
      );

  InputDecoration _inputDecoration(IconData icon, String hintText) =>
      InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(icon, color: Colors.grey),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      );

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
        Navigator.pushReplacementNamed(context, '/');
      } catch (e) {
        print("Sign Up Error: $e");
      }
    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }
}
