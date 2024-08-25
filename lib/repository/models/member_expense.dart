class MemberExpenseModal {
  List<Data>? data;
  bool? error;
  String? message;
  int? status;
  bool? success;

  MemberExpenseModal(
      {this.data, this.error, this.message, this.status, this.success});

  MemberExpenseModal.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
    status = json['status'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? memberId;
  String? memberName;
  num? overallAmount;
  String? status;
  List<PendingDetails>? pendingDetails;

  Data(
      {this.memberId,
        this.memberName,
        this.overallAmount,
        this.status,
        this.pendingDetails});

  Data.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    memberName = json['member_name'];
    overallAmount = json['overall_amount'];
    status = json['status'];
    if (json['pending_details'] != null) {
      pendingDetails = <PendingDetails>[];
      json['pending_details'].forEach((v) {
        pendingDetails!.add(new PendingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_id'] = this.memberId;
    data['member_name'] = this.memberName;
    data['overall_amount'] = this.overallAmount;
    data['status'] = this.status;
    if (this.pendingDetails != null) {
      data['pending_details'] =
          this.pendingDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingDetails {
  int? id;
  int? groupId;
  String? groupDesc;
  int? groupAdminId;
  String? groupAdminName;
  String? creditorName;
  String? debtorName;
  num? expenseAmount;
  int? creditbyId;
  String? groupName;

  // "creditor_name": "ig",
  // "debtor_name": "ag",
  // "expense_amount

  PendingDetails(
      {this.id,
        this.groupId,
        this.groupDesc,
        this.groupAdminId,
        this.groupAdminName,
        this.debtorName,
        this.creditorName,
        this.expenseAmount,
        this.creditbyId,
        this.groupName,

      });

  PendingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    groupDesc = json['group_desc'];
    groupAdminId = json['group_admin_id'];
    groupAdminName = json['group_admin_name'];
    creditorName = json["creditor_name"];
    debtorName = json["debtor_name"];
    expenseAmount = json["expense_amount"];
    creditbyId = json["creditby_id"];
    groupName = json["group_name"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['group_desc'] = this.groupDesc;
    data['group_admin_id'] = this.groupAdminId;
    data['group_admin_name'] = this.groupAdminName;
    data['creditor_name'] = this.creditorName;
    data["debtor_name"] = this.debtorName;
    data["expense_amount"] = this.expenseAmount;
    data["creditby_id"] = this.creditbyId;
    data["group_name"] = this.groupName;

    return data;
  }
}
