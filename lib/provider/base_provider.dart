import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import '../helpers/error_handler.dart';
import '../helpers/helpers.dart';
import '../main.dart';
import '../model/appCredential.dart';
import '../model/result.dart';
import '../model/user.dart';
import '../repository/firebase_Auth.dart';
import '../repository/firebase_database.dart';

class BaseProvider extends ChangeNotifier {
  UserDetail? _currentUser;
  final List<AppCredential> _appDetails = [];
  late final List<AppInfo> _appList;
  Future<void> getAppList() async {
    _appList = await InstalledApps.getInstalledApps();
    notifyListeners();
  }

  Future<void> signUp(UserDetail? user) async {
    try {
      Result? result =
          await FirebaseAuthentication.authentication.signUp(user: user);
      if (result?.successMessage != null) {
        final context = scaffoldKey?.currentContext;
        snackBarMessage(
          result?.successMessage,
          scaffoldKey?.currentContext,
        );
        _currentUser = user;
        if (context != null) {
          Navigator.of(context).pushNamed('/home');
        }
      } else {
        snackBarMessage(
          result?.errorMessage,
          scaffoldKey?.currentContext,
        );
      }
    } catch (_) {}
  }

  Future<void> logIn(UserDetail? user) async {
    try {
      Result? result =
          await FirebaseAuthentication.authentication.login(user: user);
      if (result?.successMessage != null) {
        final context = scaffoldKey?.currentContext;
        snackBarMessage(
          result?.successMessage,
          scaffoldKey?.currentContext,
        );
        user?.uid = result?.data.user?.uid;
        await storeCurrentUser(user);
        _currentUser = user;
        if (context != null) {
          // getAppDetails();
          Navigator.of(context).pushNamed('/home');
        }
      } else {
        snackBarMessage(
          result?.errorMessage,
          scaffoldKey?.currentContext,
        );
      }
    } catch (_) {}
  }

  Future<void> addPassword(AppCredential? credential) async {
    try {
      if (credential != null) {
        Result? result =
            await FirebaseDB.db.savePassword(_currentUser, credential);

        if (result?.successMessage != null) {
          getAppDetails();
          final context = scaffoldKey?.currentContext;
          snackBarMessage(
            result?.successMessage,
            scaffoldKey?.currentContext,
          );
          if (context != null) {
            Navigator.of(context).pop();
          }
        } else {
          snackBarMessage(
            result?.errorMessage,
            scaffoldKey?.currentContext,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserDetails() async {
    try {
      final uid = await getCurrentUser();
      if (uid != null) {
        Result? result = await FirebaseDB.db.getUserDetails(uid);

        if (result?.successMessage != null) {
          final data = result?.data;
          if (data != null) {
            final userDetail = data.data();
            _currentUser = UserDetail(
              userName: userDetail['name'],
              email: userDetail['email'],
              uid: uid,
            );
            await getAppDetails();
          }
          snackBarMessage(
            result?.successMessage,
            scaffoldKey?.currentContext,
          );
          notifyListeners();
        } else {
          snackBarMessage(
            result?.errorMessage,
            scaffoldKey?.currentContext,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAppDetails() async {
    try {
      final uid = _currentUser?.uid;
      if (uid != null) {
        Result? result = await FirebaseDB.db.getAppDetails(_currentUser);

        if (result?.successMessage != null) {
          final docs = result?.data.docs;
          if (docs != null) {
            // await (result?.data.docs).map((e) {
            //   AppCredential _cred = AppCredential.fromJSON(e.data());
            //   _appDetails.add(_cred);
            // });
            _appDetails.clear();
            for (int i = 0; i < docs.length; i++) {
              AppCredential? _cred = AppCredential.fromJSON(docs[i].data());
              _appDetails.add(_cred);
              print(_appDetails[i]);
            }
          }
          snackBarMessage(
            result?.successMessage,
            scaffoldKey?.currentContext,
          );
          notifyListeners();
        } else {
          snackBarMessage(
            result?.errorMessage,
            scaffoldKey?.currentContext,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCredential(AppCredential? credential) async {
    try {
      final uid = _currentUser?.uid;
      if (uid != null) {
        Result? result =
            await FirebaseDB.db.deleteAppCredential(_currentUser, credential);
        if (result?.successMessage != null) {
          getAppDetails();
          snackBarMessage(
            result?.successMessage,
            scaffoldKey?.currentContext,
          );
        } else {
          snackBarMessage(
            result?.errorMessage,
            scaffoldKey?.currentContext,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCredential(AppCredential? credential) async {
    try {
      final uid = _currentUser?.uid;
      if (uid != null) {
        Result? result =
            await FirebaseDB.db.updateAppCredential(_currentUser, credential);
        if (result?.successMessage != null) {
          getAppDetails();
          final context = scaffoldKey?.currentContext;
          snackBarMessage(
            result?.successMessage,
            scaffoldKey?.currentContext,
          );
          if (context != null) {
            Navigator.of(context).pop();
          }
        } else {
          snackBarMessage(
            result?.errorMessage,
            scaffoldKey?.currentContext,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  UserDetail? get currentUser => _currentUser;

  List<AppCredential> get appDetails => _appDetails;
}
