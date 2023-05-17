class AppCredential {
  String? appName;
  String? userName;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt = DateTime.now();
  AppCredential({
    this.appName,
    this.userName,
    this.password,
    this.createdAt,
  });

  AppCredential.fromJSON(Map<String, dynamic> json) {
    appName = json['appName'] ?? '';
    userName = json['userName'] ?? '';
    password = json['password'] ?? '';
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map toMap() {
    var map = <String, dynamic>{
      'appName': appName,
      'password': password,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
    return map;
  }
}
