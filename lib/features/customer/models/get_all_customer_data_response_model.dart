class GetAllCustomerDataResponseModel {
  GetAllCustomerDataResponseModel({
    this.status,
    this.code,
    this.data,
  });

  factory GetAllCustomerDataResponseModel.fromJson(Map<String, dynamic> json) {
    return GetAllCustomerDataResponseModel(
      status: json['status'] as String?,
      code: json['code'] as int?,
      data: json['data'] != null ? GetAllCustomerDataData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  final String? status;
  final int? code;
  final GetAllCustomerDataData? data;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'data': data?.toJson(),
    };
  }
}

class GetAllCustomerDataData {
  GetAllCustomerDataData({
    this.items,
    this.total,
    this.page,
    this.size,
    this.pages,
  });

  factory GetAllCustomerDataData.fromJson(Map<String, dynamic> json) {
    return GetAllCustomerDataData(
      items: json['items'] != null
          ? (json['items'] as List<dynamic>)
              .map((item) => GetAllCustomerDataItem.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      total: json['total'] as int?,
      page: json['page'] as int?,
      size: json['size'] as int?,
      pages: json['pages'] as int?,
    );
  }

  final List<GetAllCustomerDataItem>? items;
  final int? total;
  final int? page;
  final int? size;
  final int? pages;

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((item) => item.toJson()).toList(),
      'total': total,
      'page': page,
      'size': size,
      'pages': pages,
    };
  }
}

class GetAllCustomerDataItem {
  GetAllCustomerDataItem({
    this.id,
    this.customerName,
    this.address,
    this.mobileNo,
    this.email,
    this.customerType,
    this.license,
    this.whatsappNo,
    this.createdAt,
    this.isBlocked,
    this.lat,
    this.long,
    this.category,
    this.customerCategory,
    this.priceGroup,
    this.city,
    this.zone,
    this.region,
    this.subRegion,
    this.territory,
    this.plant,
    this.creditLimit,
    this.pendingSecurityDeposit,
    this.originalCreatedAt,
    this.outstanding,
    this.pendingOrdersTotal,
    this.sales,
    this.salesReturn,
    this.collection,
    this.riskCategory,
    this.availableCredit,
  });

  factory GetAllCustomerDataItem.fromJson(Map<String, dynamic> json) {
    return GetAllCustomerDataItem(
      id: json['id'] as String?,
      customerName: json['customer_name'] as String?,
      address: json['address'] as String?,
      mobileNo: json['mobile_no'] as String?,
      email: json['email'] as String?,
      customerType: json['customer_type'] as String?,
      license: json['license'] != null ? CustomerLicense.fromJson(json['license'] as Map<String, dynamic>) : null,
      whatsappNo: json['whatsapp_no'] as String?,
      createdAt: json['created_at'] as String?,
      isBlocked: json['is_blocked'] as bool?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      category:
          json['category'] != null ? CustomerCategoryItem.fromJson(json['category'] as Map<String, dynamic>) : null,
      customerCategory: json['customer_category'] != null
          ? CustomerCategoryItem.fromJson(json['customer_category'] as Map<String, dynamic>)
          : null,
      priceGroup: json['price_group'] != null ? PriceGroup.fromJson(json['price_group'] as Map<String, dynamic>) : null,
      city: json['city'] as String?,
      zone: json['zone'] != null ? LocationItem.fromJson(json['zone'] as Map<String, dynamic>) : null,
      region: json['region'] != null ? LocationItem.fromJson(json['region'] as Map<String, dynamic>) : null,
      subRegion: json['sub_region'] != null ? LocationItem.fromJson(json['sub_region'] as Map<String, dynamic>) : null,
      territory: json['territory'] != null ? Territory.fromJson(json['territory'] as Map<String, dynamic>) : null,
      plant: json['plant'] != null ? Plant.fromJson(json['plant'] as Map<String, dynamic>) : null,
      creditLimit: json['credit_limit'] as num?,
      pendingSecurityDeposit: json['pending_security_deposit'] as bool?,
      originalCreatedAt: json['original_created_at'] as String?,
      outstanding: json['outstanding'] as num?,
      pendingOrdersTotal: json['pending_orders_total'] as num?,
      sales: json['sales'] as num?,
      salesReturn: json['sales_return'] as num?,
      collection: json['collection'] as num?,
      riskCategory: json['risk_category'] as String?,
      availableCredit: json['available_credit'] as num?,
    );
  }

  final String? id;
  final String? customerName;
  final String? address;
  final String? mobileNo;
  final String? email;
  final String? customerType;
  final CustomerLicense? license;
  final String? whatsappNo;
  final String? createdAt;
  final bool? isBlocked;
  final String? lat;
  final String? long;
  final CustomerCategoryItem? category;
  final CustomerCategoryItem? customerCategory;
  final PriceGroup? priceGroup;
  final String? city;
  final LocationItem? zone;
  final LocationItem? region;
  final LocationItem? subRegion;
  final Territory? territory;
  final Plant? plant;
  final num? creditLimit;
  final bool? pendingSecurityDeposit;
  final String? originalCreatedAt;
  final num? outstanding;
  final num? pendingOrdersTotal;
  final num? sales;
  final num? salesReturn;
  final num? collection;
  final String? riskCategory;
  final num? availableCredit;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
      'address': address,
      'mobile_no': mobileNo,
      'email': email,
      'customer_type': customerType,
      'license': license?.toJson(),
      'whatsapp_no': whatsappNo,
      'created_at': createdAt,
      'is_blocked': isBlocked,
      'lat': lat,
      'long': long,
      'category': category?.toJson(),
      'customer_category': customerCategory?.toJson(),
      'price_group': priceGroup?.toJson(),
      'city': city,
      'zone': zone?.toJson(),
      'region': region?.toJson(),
      'sub_region': subRegion?.toJson(),
      'territory': territory?.toJson(),
      'plant': plant?.toJson(),
      'credit_limit': creditLimit,
      'pending_security_deposit': pendingSecurityDeposit,
      'original_created_at': originalCreatedAt,
      'outstanding': outstanding,
      'pending_orders_total': pendingOrdersTotal,
      'sales': sales,
      'sales_return': salesReturn,
      'collection': collection,
      'risk_category': riskCategory,
      'available_credit': availableCredit,
    };
  }
}

class CustomerLicense {
  CustomerLicense({
    this.id,
    this.number,
    this.status,
    this.validity,
  });

  factory CustomerLicense.fromJson(Map<String, dynamic> json) {
    return CustomerLicense(
      id: json['id'] as int?,
      number: json['number'] as String?,
      status: json['status'] as bool?,
      validity: json['validity'] as String?,
    );
  }

  final int? id;
  final String? number;
  final bool? status;
  final String? validity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'status': status,
      'validity': validity,
    };
  }
}

class CustomerCategoryItem {
  CustomerCategoryItem({
    this.id,
    this.name,
  });

  factory CustomerCategoryItem.fromJson(Map<String, dynamic> json) {
    return CustomerCategoryItem(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }

  final String? id;
  final String? name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class PriceGroup {
  PriceGroup({
    this.id,
    this.description,
  });

  factory PriceGroup.fromJson(Map<String, dynamic> json) {
    return PriceGroup(
      id: json['id'] as String?,
      description: json['description'] as String?,
    );
  }

  final String? id;
  final String? description;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
    };
  }
}

class LocationItem {
  LocationItem({
    this.id,
    this.name,
  });

  factory LocationItem.fromJson(Map<String, dynamic> json) {
    return LocationItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  final int? id;
  final String? name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Territory {
  Territory({
    this.id,
    this.name,
  });

  factory Territory.fromJson(Map<String, dynamic> json) {
    return Territory(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }

  final String? id;
  final String? name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Plant {
  Plant({
    this.id,
    this.description,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] as String?,
      description: json['description'] as String?,
    );
  }

  final String? id;
  final String? description;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
    };
  }
}
