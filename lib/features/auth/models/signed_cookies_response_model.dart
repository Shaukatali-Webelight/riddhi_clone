class SignedCookiesResponseModel {
  SignedCookiesResponseModel({
    this.status,
    this.code,
    this.data,
  });

  SignedCookiesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    code = json['code'] as int?;
    data = json['data'] != null ? Cookies.fromJson(json['data'] as Map<String, dynamic>) : null;
  }
  String? status;
  int? code;
  Cookies? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Cookies {
  Cookies({
    this.cloudFrontPolicy,
    this.cloudFrontSignature,
    this.cloudFrontKeyPairId,
  });

  Cookies.fromJson(Map<String, dynamic> json) {
    cloudFrontPolicy = json['CloudFrontPolicy'] as String?;
    cloudFrontSignature = json['CloudFrontSignature'] as String?;
    cloudFrontKeyPairId = json['CloudFrontKeyPairId'] as String?;
  }
  String? cloudFrontPolicy;
  String? cloudFrontSignature;
  String? cloudFrontKeyPairId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['CloudFrontPolicy'] = cloudFrontPolicy;
    data['CloudFrontSignature'] = cloudFrontSignature;
    data['CloudFrontKeyPairId'] = cloudFrontKeyPairId;
    return data;
  }
}
