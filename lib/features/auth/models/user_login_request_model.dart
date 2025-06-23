class LoginRequestModel {
  LoginRequestModel({
    this.phone,
    this.password,
    this.loginType = 'MOBILE',
    this.apkVersion,
    this.mobileDevice,
    this.fcmToken,
  });

  String? phone;
  String? password;
  String? loginType;
  String? apkVersion;
  String? mobileDevice;
  String? fcmToken;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['login_type'] = loginType;
    data['apk_version'] = apkVersion;
    data['mobile_device'] = mobileDevice;
    data['fcm_token'] = fcmToken;
    return data;
  }
}
