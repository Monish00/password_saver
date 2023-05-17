import 'appCredential.dart';

class UserDetail {
  String? uid;
  String? userName;
  String? email;
  String? password;
  List<AppCredential>? appCredential;
  UserDetail({
    this.uid,
    this.userName,
    this.password,
    this.email,
    this.appCredential,
  });
}
