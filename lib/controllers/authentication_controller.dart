import 'package:firebase_auth/firebase_auth.dart';
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
