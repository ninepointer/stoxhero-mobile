class MyWithdrawalsListResponse {
  String? status;
  List<MyWithdrawalsList>? data;

  MyWithdrawalsListResponse({this.status, this.data});

  MyWithdrawalsListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MyWithdrawalsList>[];
      json['data'].forEach((v) {
        data!.add(new MyWithdrawalsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyWithdrawalsList {
  String? sId;
  num? amount;
  String? user;
  String? userWallet;
  String? walletTransactionId;
  String? withdrawalStatus;
  List<Actions>? actions;
  // List<Null>? tickets;
  String? createdBy;
  String? lastModifiedBy;
  String? withdrawalRequestDate;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;
  String? recipientReference;
  String? settlementAccount;
  String? settlementMethod;
  String? settlementTransactionId;
  String? withdrawalSettlementDate;
  String? rejectionReason;

  MyWithdrawalsList(
      {this.sId,
      this.amount,
      this.user,
      this.userWallet,
      this.walletTransactionId,
      this.withdrawalStatus,
      this.actions,
      // this.tickets,
      this.createdBy,
      this.lastModifiedBy,
      this.withdrawalRequestDate,
      this.createdOn,
      this.lastModifiedOn,
      this.iV,
      this.recipientReference,
      this.settlementAccount,
      this.settlementMethod,
      this.settlementTransactionId,
      this.withdrawalSettlementDate,
      this.rejectionReason});

  MyWithdrawalsList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    amount = json['amount'];
    user = json['user'];
    userWallet = json['userWallet'];
    walletTransactionId = json['walletTransactionId'];
    withdrawalStatus = json['withdrawalStatus'];
    if (json['actions'] != null) {
      actions = <Actions>[];
      json['actions'].forEach((v) {
        actions!.add(new Actions.fromJson(v));
      });
    }
    // if (json['tickets'] != null) {
    //   tickets = <Null>[];
    //   json['tickets'].forEach((v) {
    //     tickets!.add(new Null.fromJson(v));
    //   });
    // }
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    withdrawalRequestDate = json['withdrawalRequestDate'];
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
    recipientReference = json['recipientReference'];
    settlementAccount = json['settlementAccount'];
    settlementMethod = json['settlementMethod'];
    settlementTransactionId = json['settlementTransactionId'];
    withdrawalSettlementDate = json['withdrawalSettlementDate'];
    rejectionReason = json['rejectionReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['amount'] = this.amount;
    data['user'] = this.user;
    data['userWallet'] = this.userWallet;
    data['walletTransactionId'] = this.walletTransactionId;
    data['withdrawalStatus'] = this.withdrawalStatus;
    if (this.actions != null) {
      data['actions'] = this.actions!.map((v) => v.toJson()).toList();
    }
    // if (this.tickets != null) {
    //   data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    // }
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['withdrawalRequestDate'] = this.withdrawalRequestDate;
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    data['recipientReference'] = this.recipientReference;
    data['settlementAccount'] = this.settlementAccount;
    data['settlementMethod'] = this.settlementMethod;
    data['settlementTransactionId'] = this.settlementTransactionId;
    data['withdrawalSettlementDate'] = this.withdrawalSettlementDate;
    data['rejectionReason'] = this.rejectionReason;
    return data;
  }
}

class Actions {
  String? actionDate;
  String? actionTitle;
  String? actionStatus;
  String? actionBy;
  String? sId;

  Actions({this.actionDate, this.actionTitle, this.actionStatus, this.actionBy, this.sId});

  Actions.fromJson(Map<String, dynamic> json) {
    actionDate = json['actionDate'];
    actionTitle = json['actionTitle'];
    actionStatus = json['actionStatus'];
    actionBy = json['actionBy'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actionDate'] = this.actionDate;
    data['actionTitle'] = this.actionTitle;
    data['actionStatus'] = this.actionStatus;
    data['actionBy'] = this.actionBy;
    data['_id'] = this.sId;
    return data;
  }
}
