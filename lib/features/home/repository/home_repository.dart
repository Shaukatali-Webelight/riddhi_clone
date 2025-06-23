import 'package:dartz/dartz.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/constants/api_endpoints.dart';
import 'package:riddhi_clone/constants/type_defs.dart';
import 'package:riddhi_clone/features/common/models/failure_model.dart';
import 'package:riddhi_clone/features/home/models/get_approval_count_response_model.dart';
import 'package:riddhi_clone/features/home/models/get_home_data_response_model.dart';
import 'package:riddhi_clone/helpers/api_helper.dart';
import 'package:riddhi_clone/resources/app_utils.dart';

abstract interface class IHomeRepository {
  FutureEither<GetHomeDataData> getHomeData();

  FutureEither<GetApprovalCountData> getApprovalCount();
}

class HomeRepository implements IHomeRepository {
  @override
  FutureEither<GetHomeDataData> getHomeData() async {
    try {
      LogHelper.logInfo('Fetching home data...');

      final response = await ApiHelper.instance.get(
        url: APIEndpoints.homeData,
        fromJson: (data) => GetHomeDataResponseModel.fromJson(
          data as Map<String, dynamic>? ?? {},
        ),
      );

      return AppUtils.handleApiResponse<GetHomeDataData>(
        response,
        (data) => (data as GetHomeDataResponseModel).data!,
      );
    } catch (e) {
      LogHelper.logError('Get home data error: $e');
      return left(Failure(message: _getHomeDataError()));
    }
  }

  @override
  FutureEither<GetApprovalCountData> getApprovalCount() async {
    try {
      LogHelper.logInfo('Fetching approval count...');

      final response = await ApiHelper.instance.get(
        url: APIEndpoints.approvalCount,
        fromJson: (data) => GetApprovalCountResponseModel.fromJson(
          data as Map<String, dynamic>? ?? {},
        ),
      );

      return AppUtils.handleApiResponse<GetApprovalCountData>(
        response,
        (data) => (data as GetApprovalCountResponseModel).data!,
      );
    } catch (e) {
      LogHelper.logError('Get approval count error: $e');
      return left(Failure(message: _getApprovalCountError()));
    }
  }

  String _getHomeDataError() {
    return 'Unable to load home data. Please check your connection and try again.';
  }

  String _getApprovalCountError() {
    return 'Unable to load approval count. Please check your connection and try again.';
  }
}
