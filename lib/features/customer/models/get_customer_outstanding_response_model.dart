class GetCustomerOutstandingResponseModel {
  const GetCustomerOutstandingResponseModel({
    this.status,
    this.code,
    this.data,
  });

  factory GetCustomerOutstandingResponseModel.fromJson(Map<String, dynamic> json) {
    return GetCustomerOutstandingResponseModel(
      status: json['status'] as String?,
      code: json['code'] as int?,
      data: json['data'] != null ? GetCustomerOutstandingData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  final String? status;
  final int? code;
  final GetCustomerOutstandingData? data;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'data': data?.toJson(),
    };
  }
}

class GetCustomerOutstandingData {
  const GetCustomerOutstandingData({
    this.outstandingData,
    this.unadjustedAmount,
    this.totalOutstanding,
  });

  factory GetCustomerOutstandingData.fromJson(Map<String, dynamic> json) {
    return GetCustomerOutstandingData(
      outstandingData: json['outstanding_data'] != null
          ? OutstandingDataDetail.fromJson(json['outstanding_data'] as Map<String, dynamic>)
          : null,
      unadjustedAmount: (json['unadjusted_amount'] as num?)?.toDouble(),
      totalOutstanding: (json['total_outstanding'] as num?)?.toDouble(),
    );
  }

  final OutstandingDataDetail? outstandingData;
  final double? unadjustedAmount;
  final double? totalOutstanding;

  Map<String, dynamic> toJson() {
    return {
      'outstanding_data': outstandingData?.toJson(),
      'unadjusted_amount': unadjustedAmount,
      'total_outstanding': totalOutstanding,
    };
  }
}

class OutstandingDataDetail {
  const OutstandingDataDetail({
    this.customerId,
    this.nonDue0To30,
    this.nonDue31To60,
    this.nonDue61To90,
    this.nonDue91To120,
    this.nonDue121To150,
    this.nonDue151To180,
    this.nonDue181To360,
    this.nonDue361To999,
    this.totalNonDue,
    this.due0To30,
    this.due31To60,
    this.due61To90,
    this.due91To120,
    this.due121To150,
    this.due151To180,
    this.due181To360,
    this.due361To999,
    this.totalDue,
  });

  factory OutstandingDataDetail.fromJson(Map<String, dynamic> json) {
    return OutstandingDataDetail(
      customerId: json['customer_id'] as String?,
      nonDue0To30: (json['non_due_0_30'] as num?)?.toDouble(),
      nonDue31To60: (json['non_due_31_60'] as num?)?.toDouble(),
      nonDue61To90: (json['non_due_61_90'] as num?)?.toDouble(),
      nonDue91To120: (json['non_due_91_120'] as num?)?.toDouble(),
      nonDue121To150: (json['non_due_121_150'] as num?)?.toDouble(),
      nonDue151To180: (json['non_due_151_180'] as num?)?.toDouble(),
      nonDue181To360: (json['non_due_181_360'] as num?)?.toDouble(),
      nonDue361To999: (json['non_due_361_999'] as num?)?.toDouble(),
      totalNonDue: (json['total_non_due'] as num?)?.toDouble(),
      due0To30: (json['due_0_30'] as num?)?.toDouble(),
      due31To60: (json['due_31_60'] as num?)?.toDouble(),
      due61To90: (json['due_61_90'] as num?)?.toDouble(),
      due91To120: (json['due_91_120'] as num?)?.toDouble(),
      due121To150: (json['due_121_150'] as num?)?.toDouble(),
      due151To180: (json['due_151_180'] as num?)?.toDouble(),
      due181To360: (json['due_181_360'] as num?)?.toDouble(),
      due361To999: (json['due_361_999'] as num?)?.toDouble(),
      totalDue: (json['total_due'] as num?)?.toDouble(),
    );
  }

  final String? customerId;
  final double? nonDue0To30;
  final double? nonDue31To60;
  final double? nonDue61To90;
  final double? nonDue91To120;
  final double? nonDue121To150;
  final double? nonDue151To180;
  final double? nonDue181To360;
  final double? nonDue361To999;
  final double? totalNonDue;
  final double? due0To30;
  final double? due31To60;
  final double? due61To90;
  final double? due91To120;
  final double? due121To150;
  final double? due151To180;
  final double? due181To360;
  final double? due361To999;
  final double? totalDue;

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'non_due_0_30': nonDue0To30,
      'non_due_31_60': nonDue31To60,
      'non_due_61_90': nonDue61To90,
      'non_due_91_120': nonDue91To120,
      'non_due_121_150': nonDue121To150,
      'non_due_151_180': nonDue151To180,
      'non_due_181_360': nonDue181To360,
      'non_due_361_999': nonDue361To999,
      'total_non_due': totalNonDue,
      'due_0_30': due0To30,
      'due_31_60': due31To60,
      'due_61_90': due61To90,
      'due_91_120': due91To120,
      'due_121_150': due121To150,
      'due_151_180': due151To180,
      'due_181_360': due181To360,
      'due_361_999': due361To999,
      'total_due': totalDue,
    };
  }
}
