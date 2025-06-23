import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riddhi_clone/constants/api_endpoints.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/type_defs.dart';
import 'package:riddhi_clone/features/common/models/failure_model.dart';
import 'package:riddhi_clone/features/common/models/master_data_model.dart';
import 'package:riddhi_clone/helpers/api_helper.dart';

final masterDataRepo = Provider(
  (ref) => MasterApiRepo(),
);

abstract interface class IMastersApiRepo {
  FutureEither<MasterData> getMastersData();
  FutureEither<MasterData?> getAdmin();
}

class MasterApiRepo implements IMastersApiRepo {
  @override
  FutureEither<MasterData> getMastersData() async {
    try {
      final response = await ApiHelper.instance.get(
        url: APIEndpoints.getMastersData,
        fromJson: (data) {
          return MasterDataModel.fromJson(
            data as Map<String, dynamic>? ?? {},
          );
        },
      );
      if (!response.hasError) {
        final model = response.data as MasterDataModel?;
        if (model?.data != null) {
          return right(model!.data!);
        } else {
          return left(
            Failure(
              message: response.message ?? AppStrings.somethingWentWrong,
            ),
          );
        }
      } else {
        return left(
          Failure(
            message: response.message ?? AppStrings.somethingWentWrong,
          ),
        );
      }
    } catch (e) {
      return left(const Failure(message: AppStrings.somethingWentWrong));
    }
  }

  @override
  FutureEither<MasterData?> getAdmin() {
    throw UnimplementedError();
  }
}
