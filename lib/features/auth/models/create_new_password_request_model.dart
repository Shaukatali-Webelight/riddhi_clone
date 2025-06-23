class CreateNewPasswordRequestModel {
  CreateNewPasswordRequestModel({
    this.phone,
    this.otp,
    this.password,
    this.confirmPassword,
  });

  String? phone;
  String? otp;
  String? password;
  String? confirmPassword;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp'] = otp;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    return data;
  }
}
