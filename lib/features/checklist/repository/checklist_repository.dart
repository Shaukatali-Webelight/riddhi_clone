import 'package:dartz/dartz.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/constants/api_endpoints.dart';
import 'package:riddhi_clone/constants/type_defs.dart';
import 'package:riddhi_clone/features/checklist/models/get_check_list_request_model.dart';
import 'package:riddhi_clone/features/checklist/models/get_check_list_response_model.dart';
import 'package:riddhi_clone/features/common/models/failure_model.dart';
import 'package:riddhi_clone/helpers/api_helper.dart';
import 'package:riddhi_clone/resources/app_utils.dart';

abstract interface class IChecklistRepository {
  FutureEither<GetCheckListData> getCheckList({
    required GetCheckListRequestModel requestModel,
  });
}

class ChecklistRepository implements IChecklistRepository {
  @override
  FutureEither<GetCheckListData> getCheckList({
    required GetCheckListRequestModel requestModel,
  }) async {
    try {
      LogHelper.logInfo('Fetching check list data from: ${APIEndpoints.homeData}');

      final response = await ApiHelper.instance.get(
        url: APIEndpoints.homeData,
        fromJson: (data) {
          LogHelper.logInfo('API Response received: $data');
          return GetCheckListResponseModel.fromJson(
            data as Map<String, dynamic>? ?? {},
          );
        },
      );

      LogHelper.logInfo('Response hasError: ${response.hasError}, statusCode: ${response.statusCode}');

      return AppUtils.handleApiResponse<GetCheckListData>(
        response,
        (data) {
          final responseModel = data as GetCheckListResponseModel;
          LogHelper.logInfo('Response data: ${responseModel.data}');
          if (responseModel.data == null) {
            throw Exception('Response data is null');
          }
          return responseModel.data!;
        },
      );
    } catch (e, stackTrace) {
      LogHelper.logError('Get check list error: $e');
      LogHelper.logError('Stack trace: $stackTrace');
      return left(Failure(message: _getCheckListError(e.toString())));
    }
  }

  String _getCheckListError(String? error) {
    LogHelper.logError('CheckList API Error: $error');
    if (error?.contains('401') == true || error?.contains('Unauthorized') == true) {
      return 'Authentication failed. Please login again.';
    } else if (error?.contains('403') == true || error?.contains('Forbidden') == true) {
      return "Access denied. You don't have permission to view this data.";
    } else if (error?.contains('404') == true) {
      return 'Service not found. Please contact support.';
    } else if (error?.contains('500') == true) {
      return 'Server error. Please try again later.';
    } else if (error?.contains('timeout') == true) {
      return 'Request timeout. Please check your connection.';
    } else if (error?.contains('No internet') == true || error?.contains('network') == true) {
      return 'No internet connection. Please check your network.';
    }
    return 'Unable to load check list data. Please try again.';
  }
}
