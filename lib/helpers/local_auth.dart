import 'package:local_auth/local_auth.dart';

class LocalAuth {
  final LocalAuthentication _auth = LocalAuthentication();
  static final LocalAuth local = LocalAuth();
  Future<bool> canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  Future<bool> authenticate() async {
    try {
      if (!await canAuthenticate()) return false;
      return await _auth.authenticate(
        localizedReason: 'use finger print',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      print(e);
      return false;
    }
  }
}
