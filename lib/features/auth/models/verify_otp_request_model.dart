class VerifyOtpRequestModel {
  VerifyOtpRequestModel({this.phone, this.otp});

  String? phone;
  String? otp;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp'] = otp;
    return data;
  }
}
