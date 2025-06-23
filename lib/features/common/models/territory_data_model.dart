import 'package:riddhi_clone/features/common/models/territory_input_model.dart';

class TerritoryDataModel {
  TerritoryDataModel({
    this.status,
    this.code,
    this.data,
  });

  TerritoryDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    code = json['code'] as int?;
    data = json['data'] != null ? TerritoryData.fromJson(json['data'] as Map<String, dynamic>) : null;
  }
  String? status;
  int? code;
  TerritoryData? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
