class GetHomeDataResponseModel {
  const GetHomeDataResponseModel({
    required this.status,
    required this.code,
    this.data,
  });

  factory GetHomeDataResponseModel.fromJson(Map<String, dynamic> json) {
    return GetHomeDataResponseModel(
      status: json['status']?.toString() ?? '',
      code: json['code'] as int? ?? 0,
      data: json['data'] != null ? GetHomeDataData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  final String status;
  final int code;
  final GetHomeDataData? data;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'data': data?.toJson(),
    };
  }
}

class GetHomeDataData {
  const GetHomeDataData({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.address,
    this.pincode,
    this.gender,
    this.whatsappNo,
    this.dob,
    this.userId,
    this.isActive,
    this.isSendSms,
    this.lat,
    this.long,
    this.zones,
    this.regions,
    this.territories,
    this.subRegions,
    this.headQuarter,
    this.empCode,
    this.salesCode,
    this.type,
    this.subtype,
    this.grade,
    this.vehicle,
    this.approver,
    this.designation,
    this.customers,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.activeInactiveDate,
    this.portalLastLogin,
    this.mobileLastLogin,
    this.mobileDevice,
    this.apkVersion,
    this.role,
    this.zonesCount,
    this.subRegionsCount,
    this.territoriesCount,
  });

  factory GetHomeDataData.fromJson(Map<String, dynamic> json) {
    return GetHomeDataData(
      id: json['id'] as int?,
      username: json['username']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      pincode: json['pincode']?.toString(),
      gender: json['gender']?.toString(),
      whatsappNo: json['whatsapp_no']?.toString(),
      dob: json['dob']?.toString(),
      userId: json['user_id']?.toString(),
      isActive: json['is_active'] as bool?,
      isSendSms: json['is_send_sms'] as bool?,
      lat: json['lat']?.toString(),
      long: json['long']?.toString(),
      zones: json['zones'] != null
          ? (json['zones'] as List<dynamic>).map((item) => Zone.fromJson(item as Map<String, dynamic>)).toList()
          : null,
      regions: json['regions'] != null
          ? (json['regions'] as List<dynamic>).map((item) => Region.fromJson(item as Map<String, dynamic>)).toList()
          : null,
      territories: json['territories'] != null
          ? (json['territories'] as List<dynamic>)
              .map((item) => Territory.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      subRegions: json['sub_regions'] != null
          ? (json['sub_regions'] as List<dynamic>)
              .map((item) => SubRegion.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      headQuarter: json['head_quarter']?.toString(),
      empCode: json['emp_code']?.toString(),
      salesCode: json['sales_code']?.toString(),
      type: json['type'] != null ? UserType.fromJson(json['type'] as Map<String, dynamic>) : null,
      subtype: json['subtype'] != null ? UserSubtype.fromJson(json['subtype'] as Map<String, dynamic>) : null,
      grade: json['grade']?.toString(),
      vehicle: json['vehicle']?.toString(),
      approver: json['approver']?.toString(),
      designation: json['designation']?.toString(),
      customers: json['customers'] != null
          ? (json['customers'] as List<dynamic>).map((item) => Customer.fromJson(item as Map<String, dynamic>)).toList()
          : null,
      createdBy: json['created_by']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      activeInactiveDate: json['active_inactive_date']?.toString(),
      portalLastLogin: json['portal_last_login']?.toString(),
      mobileLastLogin: json['mobile_last_login']?.toString(),
      mobileDevice: json['mobile_device']?.toString(),
      apkVersion: json['apk_version']?.toString(),
      role: json['role'] != null ? Role.fromJson(json['role'] as Map<String, dynamic>) : null,
      zonesCount: json['zones_count'] as int?,
      subRegionsCount: json['sub_regions_count'] as int?,
      territoriesCount: json['territories_count'] as int?,
    );
  }

  final int? id;
  final String? username;
  final String? email;
  final String? phone;
  final String? address;
  final String? pincode;
  final String? gender;
  final String? whatsappNo;
  final String? dob;
  final String? userId;
  final bool? isActive;
  final bool? isSendSms;
  final String? lat;
  final String? long;
  final List<Zone>? zones;
  final List<Region>? regions;
  final List<Territory>? territories;
  final List<SubRegion>? subRegions;
  final String? headQuarter;
  final String? empCode;
  final String? salesCode;
  final UserType? type;
  final UserSubtype? subtype;
  final String? grade;
  final String? vehicle;
  final String? approver;
  final String? designation;
  final List<Customer>? customers;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String? activeInactiveDate;
  final String? portalLastLogin;
  final String? mobileLastLogin;
  final String? mobileDevice;
  final String? apkVersion;
  final Role? role;
  final int? zonesCount;
  final int? subRegionsCount;
  final int? territoriesCount;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'address': address,
      'pincode': pincode,
      'gender': gender,
      'whatsapp_no': whatsappNo,
      'dob': dob,
      'user_id': userId,
      'is_active': isActive,
      'is_send_sms': isSendSms,
      'lat': lat,
      'long': long,
      'zones': zones?.map((item) => item.toJson()).toList(),
      'regions': regions?.map((item) => item.toJson()).toList(),
      'territories': territories?.map((item) => item.toJson()).toList(),
      'sub_regions': subRegions?.map((item) => item.toJson()).toList(),
      'head_quarter': headQuarter,
      'emp_code': empCode,
      'sales_code': salesCode,
      'type': type?.toJson(),
      'subtype': subtype?.toJson(),
      'grade': grade,
      'vehicle': vehicle,
      'approver': approver,
      'designation': designation,
      'customers': customers?.map((item) => item.toJson()).toList(),
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'active_inactive_date': activeInactiveDate,
      'portal_last_login': portalLastLogin,
      'mobile_last_login': mobileLastLogin,
      'mobile_device': mobileDevice,
      'apk_version': apkVersion,
      'role': role?.toJson(),
      'zones_count': zonesCount,
      'sub_regions_count': subRegionsCount,
      'territories_count': territoriesCount,
    };
  }
}

class Zone {
  const Zone({
    this.id,
    this.name,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'] as int?,
      name: json['name']?.toString(),
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

class Region {
  const Region({
    this.id,
    this.name,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
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

class Territory {
  const Territory({
    this.id,
    this.name,
  });

  factory Territory.fromJson(Map<String, dynamic> json) {
    return Territory(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
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

class SubRegion {
  const SubRegion({
    this.id,
    this.name,
  });

  factory SubRegion.fromJson(Map<String, dynamic> json) {
    return SubRegion(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
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

class UserType {
  const UserType({
    this.id,
    this.name,
  });

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
      id: json['id'] as int?,
      name: json['name']?.toString(),
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

class UserSubtype {
  const UserSubtype({
    this.id,
    this.name,
  });

  factory UserSubtype.fromJson(Map<String, dynamic> json) {
    return UserSubtype(
      id: json['id'] as int?,
      name: json['name']?.toString(),
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

class Customer {
  const Customer({
    this.id,
    this.customerName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id']?.toString(),
      customerName: json['customer_name']?.toString(),
    );
  }

  final String? id;
  final String? customerName;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
    };
  }
}

class Role {
  const Role({
    this.id,
    this.name,
    this.modules,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as int?,
      name: json['name']?.toString(),
      modules: json['modules'] != null
          ? (json['modules'] as List<dynamic>).map((item) => Module.fromJson(item as Map<String, dynamic>)).toList()
          : null,
    );
  }

  final int? id;
  final String? name;
  final List<Module>? modules;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'modules': modules?.map((item) => item.toJson()).toList(),
    };
  }
}

class Module {
  const Module({
    this.id,
    this.name,
    this.childModules,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'] as int?,
      name: json['name']?.toString(),
      childModules: json['child_modules'] != null
          ? (json['child_modules'] as List<dynamic>)
              .map((item) => ChildModule.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  final int? id;
  final String? name;
  final List<ChildModule>? childModules;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'child_modules': childModules?.map((item) => item.toJson()).toList(),
    };
  }
}

class ChildModule {
  const ChildModule({
    this.id,
    this.name,
    this.permissions,
  });

  factory ChildModule.fromJson(Map<String, dynamic> json) {
    return ChildModule(
      id: json['id'] as int?,
      name: json['name']?.toString(),
      permissions: json['permissions'] != null
          ? (json['permissions'] as List<dynamic>)
              .map((item) => Permission.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  final int? id;
  final String? name;
  final List<Permission>? permissions;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions?.map((item) => item.toJson()).toList(),
    };
  }
}

class Permission {
  const Permission({
    this.id,
    this.name,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'] as int?,
      name: json['name']?.toString(),
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
