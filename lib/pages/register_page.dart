import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _passwordVisible = false;
  TextEditingController _captchaController = TextEditingController();
  String _captchaQuestion = '';
  int _captchaAnswer = 0;

  @override
  void initState() {
    super.initState();
    _generateRandomCaptcha();
  }

  @override
  void dispose() {
    _captchaController.dispose();
    super.dispose();
  }

  void _generateRandomCaptcha() {
    // We create a random number between 9 and 100 and subtract 2
    int firstNumber = Random().nextInt(92) + 9;
    int secondNumber = Random().nextInt(92) + 9;
    _captchaQuestion = '$firstNumber + $secondNumber';
    _captchaAnswer = firstNumber + secondNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueAccent, Colors.blue],
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Register Now',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildNameField(),
                SizedBox(height: 10),
                _buildEmailField(),
                SizedBox(height: 10),
                _buildPasswordField(),
                SizedBox(height: 10),
                _buildConfirmPasswordField(),
                SizedBox(height: 20),
                Text(
                  'What is $_captchaQuestion?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                _buildCaptchaField(),
                SizedBox(height: 20),
                _buildRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'Enter your name',
        prefixIcon: Icon(Icons.person),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onChanged: (value) {
        _email = value;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
      onChanged: (value) {
        _password = value;
      },
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value != _password) {
          return 'Passwords do not match';
        }
        return null;
      },
      onChanged: (value) {
        _confirmPassword = value;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Confirm your password',
        prefixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildCaptchaField() {
    return TextFormField(
      controller: _captchaController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please solve the CAPTCHA';
        }
        if (int.tryParse(value) != _captchaAnswer) {
          return 'Incorrect answer';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Answer',
        hintText: 'Enter the answer',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          await _registerUser(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Text(
          'Register',
          style: TextStyle(fontSize: 18),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: Colors.white,
        onPrimary: Colors.blueAccent,
      ),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', _name);

      print('Saved Name: $_name');
      print('Registered Email: ${userCredential.user!.email}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully Registered!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
      Navigator.pushReplacementNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterPage(),
  ));
}