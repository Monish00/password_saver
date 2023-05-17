import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/appCredential.dart';
import '../model/result.dart';
import '../model/user.dart';

class FirebaseDB {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static final db = FirebaseDB();

  Future<Result?> savePassword(
    UserDetail? user,
    AppCredential credential,
  ) async {
    try {
      final uid = user?.uid;
      if (uid != null) {
        await _fireStore
            .collection('users')
            .doc(uid)
            .collection('AppData')
            .doc(credential.appName)
            .set({
          'appName': credential.appName,
          'userName': credential.userName,
          'password': credential.password,
        });
        return Result(
          successMessage: 'App credential added successfully',
        );
      } else {
        return Result(errorMessage: 'Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      return Result(errorMessage: e.message ?? 'Something went wrong');
    }
  }

  Future<Result?> getAppDetails(UserDetail? user) async {
    try {
      final uid = user?.uid;
      if (uid != null) {
        QuerySnapshot<Map<String, dynamic>> appCredentials = await _fireStore
            .collection('users')
            .doc(uid)
            .collection('AppData')
            .get();
        return Result(
          successMessage: 'App credential retrieved',
          data: appCredentials,
        );
      } else {
        return Result(errorMessage: 'Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      return Result(errorMessage: e.message ?? 'Something went wrong');
    }
  }

  Future<Result?> deleteAppCredential(
      UserDetail? user, AppCredential? credential) async {
    try {
      final uid = user?.uid;
      final doc = credential?.appName;
      if (uid != null && doc != null) {
        await _fireStore
            .collection('users')
            .doc(uid)
            .collection('AppData')
            .doc(doc)
            .delete();
        return Result(
          successMessage: 'App credential deleted successfully',
        );
      } else {
        return Result(errorMessage: 'Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      return Result(errorMessage: e.message ?? 'Something went wrong');
    }
  }
}
