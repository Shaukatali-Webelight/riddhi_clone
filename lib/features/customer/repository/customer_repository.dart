import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riddhi_clone/constants/api_endpoints.dart';
import 'package:riddhi_clone/constants/type_defs.dart';
import 'package:riddhi_clone/features/common/models/failure_model.dart';
import 'package:riddhi_clone/features/customer/models/get_all_customer_data_request_model.dart';
import 'package:riddhi_clone/features/customer/models/get_all_customer_data_response_model.dart';
import 'package:riddhi_clone/features/customer/models/get_customer_outstanding_request_model.dart';
import 'package:riddhi_clone/features/customer/models/get_customer_outstanding_response_model.dart';
import 'package:riddhi_clone/helpers/api_helper.dart';
import 'package:riddhi_clone/resources/app_utils.dart';

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return CustomerRepository();
});

abstract interface class ICustomerRepository {
  FutureEither<GetAllCustomerDataData> getAllCustomerData({
    required GetAllCustomerRequestModel requestModel,
  });

  FutureEither<GetCustomerOutstandingData> getCustomerOutstanding({
    required GetCustomerOutstandingRequestModel requestModel,
  });
}

class CustomerRepository implements ICustomerRepository {
  @override
  FutureEither<GetAllCustomerDataData> getAllCustomerData({
    required GetAllCustomerRequestModel requestModel,
  }) async {
    try {
      final response = await ApiHelper.instance.get(
        url: APIEndpoints.customer,
        queryParams: requestModel.toJson(),
        fromJson: (data) => GetAllCustomerDataResponseModel.fromJson(data ?? {}),
      );

      return AppUtils.handleApiResponse<GetAllCustomerDataData>(
        response,
        (data) => (data as GetAllCustomerDataResponseModel).data ?? GetAllCustomerDataData(),
      );
    } catch (e) {
      return left(Failure(message: _getGetAllCustomerDataError()));
    }
  }

  @override
  FutureEither<GetCustomerOutstandingData> getCustomerOutstanding({
    required GetCustomerOutstandingRequestModel requestModel,
  }) async {
    try {
      final response = await ApiHelper.instance.get(
        url: APIEndpoints.getCustomerOutstanding(requestModel.customerId),
        fromJson: (data) => GetCustomerOutstandingResponseModel.fromJson(data ?? {}),
      );

      return AppUtils.handleApiResponse<GetCustomerOutstandingData>(
        response,
        (data) => (data as GetCustomerOutstandingResponseModel).data ?? const GetCustomerOutstandingData(),
      );
    } catch (e) {
      return left(Failure(message: _getCustomerOutstandingError()));
    }
  }

  String _getGetAllCustomerDataError() {
    return 'Unable to load customers. Check your connection and try again.';
  }

  String _getCustomerOutstandingError() {
    return 'Unable to load customer outstanding data. Check your connection and try again.';
  }
}
