import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/result.dart';
import '../model/user.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static final authentication = FirebaseAuthentication();
  Future<Result?> signUp({UserDetail? user}) async {
    print('################ SignIn ##############');
    try {
      final email = user?.email;
      final password = user?.password;
      if (email != null && password != null) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _fireStore
            .collection('users')
            .doc(credential.user?.uid ?? email)
            .set({
          'name': user?.userName,
          'email': email,
          'password': password,
        });

        return Result(
          successMessage: 'Signed in successfully',
          data: credential,
        );
      } else {
        return Result(errorMessage: 'Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      return Result(errorMessage: e.message ?? 'Something went wrong');
    }
  }

  Future<Result?> login({UserDetail? user}) async {
    print('################ login ##############');
    try {
      final email = user?.email;
      final password = user?.password;
      if (email != null && password != null) {
        final UserCredential credential = await _auth
            .signInWithEmailAndPassword(email: email, password: password);
        return Result(
          successMessage: 'Signed in successfully',
          data: credential,
        );
      } else {
        return Result(errorMessage: 'Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      return Result(errorMessage: e.message ?? 'Something went wrong');
    }
  }
}
