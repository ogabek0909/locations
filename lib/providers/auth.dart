import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // String _token;
  // String _userId;
  // String _expiryDate;
  

  Future<void> signIn(String email, String password) async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }
  Future<void> signUp(String email, String password) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDO3IAAHpizy-oC0_Usx3lP2HCpsqYb0J4');
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );
    print(jsonDecode(response.body));
  }
}
