// ignore_for_file: avoid_print, unnecessary_nullable_for_final_variable_declarations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credentials;
    } catch (e) {
      print('Error logging in with email and password: $e');
      return null;
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final credentials = await _auth.signInWithCredential(googleCredential);
      return credentials;
    } catch (e) {
      print('Error logging in with Google: $e');
      return null;
    }
  }

  Future<UserCredential?> loginWithFacebook() async {
    try {
      final LoginResult? loginResult = await FacebookAuth.instance.login();

      if (loginResult != null) {
        final OAuthCredential facebookCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        final UserCredential userCredential =
            await _auth.signInWithCredential(facebookCredential);

        return userCredential;
      } else {
        print('Facebook login failed.');
        return null;
      }
    } catch (e) {
      print('Error logging in with Facebook: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
