class MasterDataModel {
  MasterDataModel({this.status, this.code, this.data});

  MasterDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    code = json['code'] as int?;
    data = json['data'] != null ? MasterData.fromJson(json['data'] as Map<String, dynamic>? ?? {}) : null;
  }
  String? status;
  int? code;
  MasterData? data;

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

class MasterData {
  MasterData({
    this.cities,
    this.regions,
    this.subRegions,
    this.territories,
    this.zones,
    this.sortByTypes,
  });

  MasterData.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      for (final v in json['cities'] as List? ?? []) {
        cities!.add(Cities.fromJson(v as Map<String, dynamic>? ?? {}));
      }
    }
    if (json['regions'] != null) {
      regions = <Regions>[];
      for (final v in json['regions'] as List? ?? []) {
        regions!.add(Regions.fromJson(v as Map<String, dynamic>? ?? {}));
      }
    }
    if (json['sub_regions'] != null) {
      subRegions = <SubRegions>[];
      for (final v in json['sub_regions'] as List? ?? []) {
        subRegions!.add(SubRegions.fromJson(v as Map<String, dynamic>? ?? {}));
      }
    }
    if (json['territories'] != null) {
      territories = <Territory>[];
      for (final v in json['territories'] as List? ?? []) {
        territories!.add(Territory.fromJson(v as Map<String, dynamic>? ?? {}));
      }
    }
    if (json['zones'] != null) {
      zones = <Zones>[];
      for (final v in json['zones'] as List? ?? []) {
        zones!.add(Zones.fromJson(v as Map<String, dynamic>? ?? {}));
      }
    }
    if (json['sort_by_types'] != null) {
      sortByTypes = <String>[];
      for (final v in json['sort_by_types'] as List? ?? []) {
        sortByTypes!.add(v as String? ?? '');
      }
    }
  }
  List<Cities>? cities;
  List<Regions>? regions;
  List<SubRegions>? subRegions;
  List<Territory>? territories;
  List<Zones>? zones;
  List<String>? sortByTypes;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    if (regions != null) {
      data['regions'] = regions!.map((v) => v.toJson()).toList();
    }
    if (subRegions != null) {
      data['sub_regions'] = subRegions!.map((v) => v.toJson()).toList();
    }
    if (territories != null) {
      data['territories'] = territories!.map((v) => v.toJson()).toList();
    }
    if (zones != null) {
      data['zones'] = zones!.map((v) => v.toJson()).toList();
    }
    if (sortByTypes != null) {
      data['sort_by_types'] = sortByTypes;
    }
    return data;
  }
}

class Cities {
  Cities({this.id, this.name});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Regions {
  Regions({this.id, this.name, this.countryKey});

  Regions.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    countryKey = json['country_key'] as String?;
  }
  String? id;
  String? name;
  String? countryKey;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_key'] = countryKey;
    return data;
  }
}

class SubRegions {
  SubRegions({this.id, this.name});

  SubRegions.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Territory {
  Territory({this.id, this.name});

  Territory.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Zones {
  Zones({this.id, this.name});

  Zones.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
