class GetCheckListResponseModel {
  const GetCheckListResponseModel({
    this.status,
    this.code,
    this.data,
  });

  factory GetCheckListResponseModel.fromJson(Map<String, dynamic> json) {
    return GetCheckListResponseModel(
      status: json['status'] as String?,
      code: json['code'] as int?,
      data: json['data'] != null ? GetCheckListData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }
  final String? status;
  final int? code;
  final GetCheckListData? data;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'data': data?.toJson(),
    };
  }
}

class GetCheckListData {
  const GetCheckListData({
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

  factory GetCheckListData.fromJson(Map<String, dynamic> json) {
    return GetCheckListData(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      pincode: json['pincode'] as String?,
      gender: json['gender'] as String?,
      whatsappNo: json['whatsapp_no'] as String?,
      dob: json['dob'] as String?,
      userId: json['user_id'] as String?,
      isActive: json['is_active'] as bool?,
      isSendSms: json['is_send_sms'] as bool?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      zones: (json['zones'] as List<dynamic>?)?.map((e) => Zone.fromJson(e as Map<String, dynamic>)).toList(),
      regions: (json['regions'] as List<dynamic>?)?.map((e) => Region.fromJson(e as Map<String, dynamic>)).toList(),
      territories:
          (json['territories'] as List<dynamic>?)?.map((e) => Territory.fromJson(e as Map<String, dynamic>)).toList(),
      subRegions:
          (json['sub_regions'] as List<dynamic>?)?.map((e) => SubRegion.fromJson(e as Map<String, dynamic>)).toList(),
      headQuarter: json['head_quarter'] as String?,
      empCode: json['emp_code'] as String?,
      salesCode: json['sales_code'] as String?,
      type: json['type'] != null ? UserType.fromJson(json['type'] as Map<String, dynamic>) : null,
      subtype: json['subtype'] != null ? UserSubtype.fromJson(json['subtype'] as Map<String, dynamic>) : null,
      grade: json['grade'] as String?,
      vehicle: json['vehicle'] as String?,
      approver: json['approver'] as String?,
      designation: json['designation'] as String?,
      customers:
          (json['customers'] as List<dynamic>?)?.map((e) => Customer.fromJson(e as Map<String, dynamic>)).toList(),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      activeInactiveDate: json['active_inactive_date'] as String?,
      portalLastLogin: json['portal_last_login'] as String?,
      mobileLastLogin: json['mobile_last_login'] as String?,
      mobileDevice: json['mobile_device'] as String?,
      apkVersion: json['apk_version'] as String?,
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
      'zones': zones?.map((e) => e.toJson()).toList(),
      'regions': regions?.map((e) => e.toJson()).toList(),
      'territories': territories?.map((e) => e.toJson()).toList(),
      'sub_regions': subRegions?.map((e) => e.toJson()).toList(),
      'head_quarter': headQuarter,
      'emp_code': empCode,
      'sales_code': salesCode,
      'type': type?.toJson(),
      'subtype': subtype?.toJson(),
      'grade': grade,
      'vehicle': vehicle,
      'approver': approver,
      'designation': designation,
      'customers': customers?.map((e) => e.toJson()).toList(),
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

class Region {
  const Region({
    this.id,
    this.name,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
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

class Territory {
  const Territory({
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

class SubRegion {
  const SubRegion({
    this.id,
    this.name,
  });

  factory SubRegion.fromJson(Map<String, dynamic> json) {
    return SubRegion(
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

class UserType {
  const UserType({
    this.id,
    this.name,
  });

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
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

class UserSubtype {
  const UserSubtype({
    this.id,
    this.name,
  });

  factory UserSubtype.fromJson(Map<String, dynamic> json) {
    return UserSubtype(
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

class Customer {
  const Customer({
    this.id,
    this.customerName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String?,
      customerName: json['customer_name'] as String?,
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
      name: json['name'] as String?,
      modules: (json['modules'] as List<dynamic>?)?.map((e) => Module.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
  final int? id;
  final String? name;
  final List<Module>? modules;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'modules': modules?.map((e) => e.toJson()).toList(),
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
      name: json['name'] as String?,
      childModules: (json['child_modules'] as List<dynamic>?)
          ?.map((e) => ChildModule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  final int? id;
  final String? name;
  final List<ChildModule>? childModules;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'child_modules': childModules?.map((e) => e.toJson()).toList(),
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
      name: json['name'] as String?,
      permissions:
          (json['permissions'] as List<dynamic>?)?.map((e) => Permission.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
  final int? id;
  final String? name;
  final List<Permission>? permissions;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions?.map((e) => e.toJson()).toList(),
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
