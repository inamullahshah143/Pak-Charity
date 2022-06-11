import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants/components/components.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN IN METHOD
  Future signIn({String email, String password, BuildContext context}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Components.showSnackBar(context, e.message);
    }
  }

  Future signOut({BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Components.showSnackBar(context, e.message);
    }
  }

  Future resetPassword(context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Components.showSnackBar(context, e.message);
      return false;
    }
  }
}
