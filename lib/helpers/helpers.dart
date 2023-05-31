import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

Future<bool> storeCurrentUser(UserDetail? user) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final uid = user?.uid;
  if (uid != null) {
    return pref.setString('currentUser', uid);
  }
  return false;
}

Future<String?> getCurrentUser() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('currentUser');
}

removeCurrentUser() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.remove('currentUser');
}

biometricVerification() async {
  final LocalAuthentication auth = LocalAuthentication();
  final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  final bool canAuthenticate =
      canAuthenticateWithBiometrics || await auth.isDeviceSupported();
}
