import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky_nti/core/firebase/fb_result.dart';
import 'package:tasky_nti/feature/auth/data/model/user_model.dart';

abstract class FbAuth {
  static CollectionReference<UserModel> get _getCollection {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toJson(),
        );
  }

  static Future<FbResult<void>> register(
    UserModel user,
    String password,
  ) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email!,
            password: password,
          );
      user.id = credential.user?.uid;
      await _getCollection.doc(user.id).set(user);
      return Succces();
    } catch (e) {
      // ignore: void_checks
      return Faluire(errorMsg: e.toString());
    }
  }
}
