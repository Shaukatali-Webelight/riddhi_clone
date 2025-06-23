class CommonResponseModel {
  CommonResponseModel({this.status, this.code, this.data});

  CommonResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    code = json['code'] as int?;
    data = json['data'] != null ? CommonData.fromJson(json['data'] as Map<String, dynamic>? ?? {}) : null;
  }
  String? status;
  int? code;
  CommonData? data;

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

class CommonData {
  CommonData({this.message});

  CommonData.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
  }
  String? message;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
