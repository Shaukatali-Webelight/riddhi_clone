class GetAllCustomerRequestModel {
  GetAllCustomerRequestModel({
    this.filters,
    this.sortBy,
    this.sortType,
    this.cities,
    this.regions,
    this.subRegions,
    this.territories,
    this.zones,
    this.page,
    this.size = 20,
    this.customerId,
    this.customerName,
  });

  List<String>? filters;
  String? sortBy;
  String? sortType;
  List<int>? cities;
  List<int>? regions;
  List<int>? subRegions;
  List<String>? territories;
  List<int>? zones;
  int? page;
  int? size;
  String? customerId;
  String? customerName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (filters != null && filters!.isNotEmpty) {
      data['filters'] = filters;
    }
    if (sortBy != null && sortBy!.isNotEmpty) {
      data['sort_by'] = sortBy;
    }
    if (sortType != null) {
      data['sort_type'] = sortType;
    }
    if (cities != null && cities!.isNotEmpty) {
      data['cities'] = cities;
    }
    if (regions != null && regions!.isNotEmpty) {
      data['regions'] = regions;
    }
    if (subRegions != null && subRegions!.isNotEmpty) {
      data['sub_regions'] = subRegions;
    }
    if (territories != null && territories!.isNotEmpty) {
      data['territories'] = territories;
    }
    if (zones != null && zones!.isNotEmpty) {
      data['zones'] = zones;
    }
    if (page != null) {
      data['page'] = page;
    }
    if (size != null) {
      data['size'] = size;
    }
    if (customerId != null && customerId!.isNotEmpty) {
      data['customer_id'] = customerId;
    }
    if (customerName != null && customerName!.isNotEmpty) {
      data['customer_name'] = customerName;
    }

    return data;
  }
}
