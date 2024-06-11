import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_enlist/controllers/authentication_controller.dart';
import 'package:lets_enlist/models/enlist_model.dart';

class FirestoreDatabaseController {
  static FirebaseFirestore firestoreDatebase = FirebaseFirestore.instance;
  static List<int>? favoriteEnlists;

  static bool isFavoriteEnlist(EnlistModel enlistModel) =>
      favoriteEnlists != null
          ? favoriteEnlists!.contains(enlistModel.index)
          : false;

  static Future<bool> appendFavoriteEnlists(EnlistModel enlistModel) async {
    try {
      // await loadFavoriteEnlists();
      favoriteEnlists!.add(enlistModel.index);
      await firestoreDatebase
          .collection('uids')
          .doc(AuthenticationController.uid)
          .set(
        {
          'favoriteEnlists': favoriteEnlists,
        },
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeFavoriteEnlists(EnlistModel enlistModel) async {
    try {
      // await loadFavoriteEnlists();
      favoriteEnlists!.remove(enlistModel.index);
      await firestoreDatebase
          .collection('uids')
          .doc(AuthenticationController.uid)
          .set(
        {
          'favoriteEnlists': favoriteEnlists,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> loadFavoriteEnlists() async {
    try {
      await firestoreDatebase
          .collection('uids')
          .doc(AuthenticationController.uid)
          .get()
          .then(
        (DocumentSnapshot<Map<String, dynamic>> doc) {
          favoriteEnlists = List<int>.from(
            doc.data()?['favoriteEnlists'] ?? [],
          );
        },
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
