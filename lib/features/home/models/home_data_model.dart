import 'package:riddhi_clone/features/common/models/master_data_model.dart';

class HomeDataModel {
  HomeDataModel({this.status, this.code, this.data});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    code = json['code'] as int?;
    data = json['data'] != null ? HomeData.fromJson(json['data'] as Map<String, dynamic>) : null;
  }

  String? status;
  int? code;
  HomeData? data;

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

class HomeData {
  HomeData({
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
    this.headQuarter,
    this.empCode,
    this.salesCode,
    this.type,
    this.subtype,
    this.grade,
    this.vehicle,
    this.approver,
    this.designation,
    this.customer,
    this.role,
  });

  HomeData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    username = json['username'] as String?;
    email = json['email'] as String?;
    phone = json['phone'] as String?;
    address = json['address'] as String?;
    pincode = json['pincode'] as int?;
    gender = json['gender'] as String?;
    whatsappNo = json['whatsapp_no'] as String?;
    dob = json['dob'] as String?;
    userId = json['user_id'] as String?;
    isActive = json['is_active'] as bool?;
    isSendSms = json['is_send_sms'] as bool?;
    lat = json['lat'] as num?;
    long = json['long'] as num?;
    if (json['zones'] != null) {
      zones = <Zones>[];
      for (final v in json['zones'] as List<dynamic>) {
        zones?.add(Zones.fromJson(v as Map<String, dynamic>));
      }
    }
    if (json['regions'] != null) {
      regions = <Regions>[];
      for (final v in json['regions'] as List<dynamic>) {
        regions?.add(Regions.fromJson(v as Map<String, dynamic>));
      }
    }
    if (json['territories'] != null) {
      territories = <Territories>[];
      for (final v in json['territories'] as List<dynamic>) {
        territories?.add(Territories.fromJson(v as Map<String, dynamic>));
      }
    }
    headQuarter = json['head_quarter'] != null ? Zones.fromJson(json['head_quarter'] as Map<String, dynamic>) : null;
    empCode = json['emp_code'] as String?;
    salesCode = json['sales_code'] as String?;
    type = json['type'] != null ? Zones.fromJson(json['type'] as Map<String, dynamic>) : null;
    subtype = json['subtype'] != null ? Zones.fromJson(json['subtype'] as Map<String, dynamic>) : null;
    grade = json['grade'] != null ? Zones.fromJson(json['grade'] as Map<String, dynamic>) : null;
    vehicle = json['vehicle'] != null ? Zones.fromJson(json['vehicle'] as Map<String, dynamic>) : null;
    approver = json['approver'] != null ? Territories.fromJson(json['approver'] as Map<String, dynamic>) : null;
    designation = json['designation'] as String?;
    customer = json['customer'] != null ? Customer.fromJson(json['customer'] as Map<String, dynamic>) : null;
    role = json['role'] != null ? Role.fromJson(json['role'] as Map<String, dynamic>) : null;
  }

  int? id;
  String? username;
  String? email;
  String? phone;
  String? address;
  int? pincode;
  String? gender;
  String? whatsappNo;
  String? dob;
  String? userId;
  bool? isActive;
  bool? isSendSms;
  num? lat;
  num? long;
  List<Zones>? zones;
  List<Regions>? regions;
  List<Territories>? territories;
  Zones? headQuarter;
  String? empCode;
  String? salesCode;
  Zones? type;
  Zones? subtype;
  Zones? grade;
  Zones? vehicle;
  Territories? approver;
  String? designation;
  Customer? customer;
  Role? role;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['pincode'] = pincode;
    data['gender'] = gender;
    data['whatsapp_no'] = whatsappNo;
    data['dob'] = dob;
    data['user_id'] = userId;
    data['is_active'] = isActive;
    data['is_send_sms'] = isSendSms;
    data['lat'] = lat;
    data['long'] = long;
    if (zones != null) {
      data['zones'] = zones!.map((v) => v.toJson()).toList();
    }
    if (regions != null) {
      data['regions'] = regions!.map((v) => v.toJson()).toList();
    }
    if (territories != null) {
      data['territories'] = territories!.map((v) => v.toJson()).toList();
    }
    if (headQuarter != null) {
      data['head_quarter'] = headQuarter!.toJson();
    }
    data['emp_code'] = empCode;
    data['sales_code'] = salesCode;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (subtype != null) {
      data['subtype'] = subtype!.toJson();
    }
    if (grade != null) {
      data['grade'] = grade!.toJson();
    }
    if (vehicle != null) {
      data['vehicle'] = vehicle!.toJson();
    }
    if (approver != null) {
      data['approver'] = approver!.toJson();
    }
    data['designation'] = designation;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (role != null) {
      data['role'] = role!.toJson();
    }
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

class Territories {
  Territories({this.id, this.name});

  Territories.fromJson(Map<String, dynamic> json) {
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

class Customer {
  Customer({this.id, this.customerName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    customerName = json['customer_name'] as String?;
  }

  int? id;
  String? customerName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['customer_name'] = customerName;
    return data;
  }
}

class Role {
  Role({this.id, this.name, this.modules});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    if (json['modules'] != null) {
      modules = <Modules>[];
      for (final v in json['modules'] as List<dynamic>) {
        modules?.add(Modules.fromJson(v as Map<String, dynamic>));
      }
    }
  }

  int? id;
  String? name;
  List<Modules>? modules;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (modules != null) {
      data['modules'] = modules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modules {
  Modules({this.id, this.name, this.childModules});

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    if (json['child_modules'] != null) {
      childModules = <ChildModules>[];
      for (final v in json['child_modules'] as List<dynamic>) {
        childModules?.add(ChildModules.fromJson(v as Map<String, dynamic>));
      }
    }
  }

  int? id;
  String? name;
  List<ChildModules>? childModules;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (childModules != null) {
      data['child_modules'] = childModules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildModules {
  ChildModules({this.id, this.name, this.permissions});

  ChildModules.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      for (final v in json['permissions'] as List<dynamic>) {
        permissions?.add(Permissions.fromJson(v as Map<String, dynamic>));
      }
    }
  }

  int? id;
  String? name;
  List<Permissions>? permissions;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  Permissions({this.id, this.name});

  Permissions.fromJson(Map<String, dynamic> json) {
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
