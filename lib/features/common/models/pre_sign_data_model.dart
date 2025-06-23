class PreSignDataModel {
  PreSignDataModel({this.data});

  PreSignDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;
  }
  Data? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Data({this.signedRequest, this.cloudFrontURL});

  Data.fromJson(Map<String, dynamic> json) {
    signedRequest =
        json['signedRequest'] != null ? SignedRequest.fromJson(json['signedRequest'] as Map<String, dynamic>) : null;
  }
  SignedRequest? signedRequest;
  String? cloudFrontURL;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (signedRequest != null) {
      data['signedRequest'] = signedRequest!.toJson();
    }
    data['cloudFrontURL'] = cloudFrontURL;
    return data;
  }
}

class SignedRequest {
  SignedRequest({this.url, this.fields});

  SignedRequest.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    fields = json['fields'] != null ? Fields.fromJson(json['fields'] as Map<String, dynamic>) : null;
  }
  String? url;
  Fields? fields;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    if (fields != null) {
      data['fields'] = fields!.toJson();
    }
    return data;
  }
}

class Fields {
  Fields({
    this.acl,
    this.contentType,
    this.key,
    this.bucket,
    this.xAmzAlgorithm,
    this.xAmzCredential,
    this.xAmzDate,
    this.xAmzSecurityToken,
    this.policy,
    this.xAmzSignature,
  });

  Fields.fromJson(Map<String, dynamic> json) {
    acl = json['acl'] as String?;
    contentType = json['Content-Type'] as String?;
    key = json['key'] as String?;
    bucket = json['bucket'] as String?;
    xAmzAlgorithm = json['X-Amz-Algorithm'] as String?;
    xAmzCredential = json['X-Amz-Credential'] as String?;
    xAmzDate = json['X-Amz-Date'] as String?;
    xAmzSecurityToken = json['X-Amz-Security-Token'] as String?;
    policy = json['Policy'] as String?;
    xAmzSignature = json['X-Amz-Signature'] as String?;
  }
  String? acl;
  String? contentType;
  String? key;
  String? bucket;
  String? xAmzAlgorithm;
  String? xAmzCredential;
  String? xAmzDate;
  String? xAmzSecurityToken;
  String? policy;
  String? xAmzSignature;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['acl'] = acl;
    data['Content-Type'] = contentType;
    data['key'] = key;
    data['bucket'] = bucket;
    data['X-Amz-Algorithm'] = xAmzAlgorithm;
    data['X-Amz-Credential'] = xAmzCredential;
    data['X-Amz-Date'] = xAmzDate;
    data['X-Amz-Security-Token'] = xAmzSecurityToken;
    data['Policy'] = policy;
    data['X-Amz-Signature'] = xAmzSignature;
    return data;
  }
}
