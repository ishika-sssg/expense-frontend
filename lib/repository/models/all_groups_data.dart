class AllGroupsData {
  Data? data;
  bool? error;
  String? message;
  int? status;
  bool? success;

  AllGroupsData(
      {this.data, this.error, this.message, this.status, this.success});

  AllGroupsData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
    message = json['message'];
    status = json['status'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  List<Alldata>? alldata;
  int? total;

  Data({this.alldata, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['alldata'] != null) {
      alldata = <Alldata>[];
      json['alldata'].forEach((v) {
        alldata!.add(new Alldata.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alldata != null) {
      data['alldata'] = this.alldata!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Alldata {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? groupName;
  String? description;
  String? category;
  int? groupAdminId;
  Admin? admin;

  Alldata(
      {this.iD,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.groupName,
        this.description,
        this.category,
        this.groupAdminId,
        this.admin});

  Alldata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    groupName = json['group_name'];
    description = json['description'];
    category = json['category'];
    groupAdminId = json['group_admin_id'];
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    data['DeletedAt'] = this.deletedAt;
    data['group_name'] = this.groupName;
    data['description'] = this.description;
    data['category'] = this.category;
    data['group_admin_id'] = this.groupAdminId;
    if (this.admin != null) {
      data['admin'] = this.admin!.toJson();
    }
    return data;
  }
}

class Admin {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? userName;
  String? email;
  String? password;

  Admin(
      {this.iD,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.userName,
        this.email,
        this.password});

  Admin.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    userName = json['user_name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    data['DeletedAt'] = this.deletedAt;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
