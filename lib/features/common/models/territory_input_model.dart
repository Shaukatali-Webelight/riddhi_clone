import 'package:riddhi_clone/features/common/models/master_data_model.dart';

class TerritoryData {
  TerritoryData({this.territories, this.total, this.page, this.size, this.pages});

  TerritoryData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      territories = <Territory>[];
      for (final v in (json['items'] as List)) {
        territories!.add(Territory.fromJson(v as Map<String, dynamic>));
      }
    }
    total = json['total'] as int?;
    page = json['page'] as int?;
    size = json['size'] as int?;
    pages = json['pages'] as int?;
  }
  List<Territory>? territories;
  int? total;
  int? page;
  int? size;
  int? pages;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (territories != null) {
      data['items'] = territories?.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['page'] = page;
    data['size'] = size;
    data['pages'] = pages;
    return data;
  }
}
