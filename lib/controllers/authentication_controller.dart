import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_enlist/controllers/firestore_database_controller.dart';

class AuthenticationController {
  static GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
  static bool hasUserCredential = false;
  static UserCredential? userCredential;

  static String get photoURL => userCredential!.user!.photoURL!;
  static String get email => userCredential!.user!.email!;
  static String get displayName => userCredential!.user!.displayName!;
  static String get uid => userCredential!.user!.uid;

  static Future<bool> signIn() async {
    return kIsWeb ? await signInWeb() : await signInApp();
  }

  static Future<bool> signInApp() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await FirestoreDatabaseController.loadFavoriteEnlists();
      hasUserCredential = true;
    } catch (_) {
      hasUserCredential = false;
    }

    return hasUserCredential;
  }

  static Future<bool> signInWeb() async {
    try {
      userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleAuthProvider);
      await FirestoreDatabaseController.loadFavoriteEnlists();
      hasUserCredential = true;
    } catch (_) {
      hasUserCredential = false;
    }

    return hasUserCredential;
  }
}
