class LoginResponseDataModel {
  LoginResponseDataModel({
    this.success,
    this.code,
    this.data,
    this.isSelfieUploaded,
    this.hoSelfieVerified,
    this.userType,
    this.zonesCount,
    this.subRegionsCount,
    this.territoriesCount,
  });
  LoginResponseDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    code = json['code'] as int?;
    data = json['data'] != null ? LoginData.fromJson(json['data'] as Map<String, dynamic>? ?? {}) : null;
    isSelfieUploaded = json['is_selfie_uploaded'] as bool?;
    hoSelfieVerified = json['ho_selfie_verified'] as String?;
    userType = json['user_type'] as String?;
    zonesCount = json['zones_count'] as int?;
    subRegionsCount = json['sub_regions_count'] as int?;
    territoriesCount = json['territories_count'] as int?;
  }
  bool? success;
  int? code;
  LoginData? data;
  bool? isSelfieUploaded;
  String? hoSelfieVerified;
  String? userType;
  int? zonesCount;
  int? subRegionsCount;
  int? territoriesCount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['is_selfie_uploaded'] = isSelfieUploaded;
    data['ho_selfie_verified'] = hoSelfieVerified;
    data['user_type'] = userType;
    data['zones_count'] = zonesCount;
    data['sub_regions_count'] = subRegionsCount;
    data['territories_count'] = territoriesCount;
    return data;
  }
}

class LoginData {
  LoginData({
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.userName,
  });

  LoginData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'] as String?;
    refreshToken = json['refresh_token'] as String?;
    userId = json['user_id'] as String?;
    userName = json['user_name'] as String?;
  }
  String? accessToken;
  String? refreshToken;
  String? userId;
  String? userName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['user_id'] = userId;
    data['user_name'] = userName;

    return data;
  }
}
