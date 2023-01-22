import 'package:flutter/material.dart';
import 'package:locations/providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { SignIn, Signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();

  InputDecoration decoration(String label) => InputDecoration(
      hintText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)));

  AuthMode _authMode = AuthMode.SignIn;

  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (_authMode == AuthMode.Signup) {
      Provider.of<Auth>(context, listen: false)
          .signUp(_emailController.text, _passwordController.text);
    }else{
      print('boshladi');
      Provider.of<Auth>(context, listen: false)
          .signUp(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final diviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: diviceSize.height,
        width: diviceSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue,
              Colors.blueAccent,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: decoration('Email'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (!value!.contains('@') || value.isEmpty) {
                      return "Invalid email!";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: decoration('Password'),
                  textInputAction: _authMode == AuthMode.Signup
                      ? TextInputAction.next
                      : TextInputAction.done,
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Must be at least 6 characters!";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    controller: _confirmController,
                    decoration: decoration('Confirm password'),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return "Invalid email!";
                      } else {
                        return null;
                      }
                    },
                  ),
                // const SizedBox(height: 15),

                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  child:
                      Text(_authMode == AuthMode.SignIn ? "SingIn" : "SignUp"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_authMode == AuthMode.SignIn) {
                          setState(() {
                            _authMode = AuthMode.Signup;
                          });
                        } else {
                          setState(() {
                            _authMode = AuthMode.SignIn;
                          });
                        }
                      },
                      child: Text(
                        _authMode == AuthMode.SignIn ? "SignUp" : "SignIn",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
