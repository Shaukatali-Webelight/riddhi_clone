class GetCustomerOutstandingRequestModel {
  const GetCustomerOutstandingRequestModel({
    required this.customerId,
  });

  factory GetCustomerOutstandingRequestModel.fromJson(Map<String, dynamic> json) {
    return GetCustomerOutstandingRequestModel(
      customerId: json['customerId'] as String,
    );
  }

  final String customerId;

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
    };
  }
}
