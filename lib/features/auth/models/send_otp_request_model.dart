class SendOtpRequestModel {
  const SendOtpRequestModel({
    required this.phone,
  });

  factory SendOtpRequestModel.fromJson(Map<String, dynamic> json) {
    return SendOtpRequestModel(
      phone: json['phone']?.toString() ?? '',
    );
  }
  final String phone;

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }
}
