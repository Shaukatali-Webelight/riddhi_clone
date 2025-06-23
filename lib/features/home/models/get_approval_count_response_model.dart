class GetApprovalCountResponseModel {
  const GetApprovalCountResponseModel({
    required this.status,
    required this.code,
    this.data,
  });

  factory GetApprovalCountResponseModel.fromJson(Map<String, dynamic> json) {
    return GetApprovalCountResponseModel(
      status: json['status']?.toString() ?? '',
      code: json['code'] as int? ?? 0,
      data: json['data'] != null ? GetApprovalCountData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  final String status;
  final int code;
  final GetApprovalCountData? data;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'data': data?.toJson(),
    };
  }
}

class GetApprovalCountData {
  const GetApprovalCountData({
    this.sdoPendingAppointmentCount,
    this.sdoPendingTerminationCount,
    this.unreadNotificationCount,
    this.orderPendingCount,
  });

  factory GetApprovalCountData.fromJson(Map<String, dynamic> json) {
    return GetApprovalCountData(
      sdoPendingAppointmentCount: json['sdo_pending_appointment_count'] as int?,
      sdoPendingTerminationCount: json['sdo_pending_termination_count'] as int?,
      unreadNotificationCount: json['unread_notification_count'] as int?,
      orderPendingCount: json['order_pending_count'] as int?,
    );
  }

  final int? sdoPendingAppointmentCount;
  final int? sdoPendingTerminationCount;
  final int? unreadNotificationCount;
  final int? orderPendingCount;

  Map<String, dynamic> toJson() {
    return {
      'sdo_pending_appointment_count': sdoPendingAppointmentCount,
      'sdo_pending_termination_count': sdoPendingTerminationCount,
      'unread_notification_count': unreadNotificationCount,
      'order_pending_count': orderPendingCount,
    };
  }
}
