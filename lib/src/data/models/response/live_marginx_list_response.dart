class LiveMarginxListResponse {
  String? status;
  List<LiveMarginX>? data;

  LiveMarginxListResponse({this.status, this.data});

  LiveMarginxListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <LiveMarginX>[];
      json['data'].forEach((v) {
        data!.add(new LiveMarginX.fromJson(v));
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

class LiveMarginX {
  String? sId;
  String? marginXName;
  String? startTime;
  String? endTime;
  String? liveTime;
  MarginXTemplate? marginXTemplate;
  List<Null>? potentialParticipants;
  int? maxParticipants;
  String? status;
  String? createdBy;
  String? lastModifiedBy;
  String? marginXExpiry;
  bool? isNifty;
  bool? isBankNifty;
  bool? isFinNifty;
  List<Participantss>? participants;
  List<Null>? sharedBy;
  List<PurchaseIntents>? purchaseIntents;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;

  LiveMarginX(
      {this.sId,
      this.marginXName,
      this.startTime,
      this.endTime,
      this.liveTime,
      this.marginXTemplate,
      this.potentialParticipants,
      this.maxParticipants,
      this.status,
      this.createdBy,
      this.lastModifiedBy,
      this.marginXExpiry,
      this.isNifty,
      this.isBankNifty,
      this.isFinNifty,
      this.participants,
      this.sharedBy,
      this.purchaseIntents,
      this.createdOn,
      this.lastModifiedOn,
      this.iV});

  LiveMarginX.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    marginXName = json['marginXName'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    liveTime = json['liveTime'];
    marginXTemplate = json['marginXTemplate'] != null
        ? new MarginXTemplate.fromJson(json['marginXTemplate'])
        : null;
    if (json['potentialParticipants'] != null) {
      potentialParticipants = <Null>[];
      json['potentialParticipants'].forEach((v) {
        // potentialParticipants!.add(new Null.fromJson(v));
      });
    }
    maxParticipants = json['maxParticipants'];
    status = json['status'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    marginXExpiry = json['marginXExpiry'];
    isNifty = json['isNifty'];
    isBankNifty = json['isBankNifty'];
    isFinNifty = json['isFinNifty'];
    if (json['participants'] != null) {
      participants = <Participantss>[];
      json['participants'].forEach((v) {
        participants!.add(new Participantss.fromJson(v));
      });
    }
    if (json['sharedBy'] != null) {
      sharedBy = <Null>[];
      json['sharedBy'].forEach((v) {
        // sharedBy!.add(new Null.fromJson(v));
      });
    }
    if (json['purchaseIntent'] != null) {
      purchaseIntents = <PurchaseIntents>[];
      json['purchaseIntent'].forEach((v) {
        purchaseIntents!.add(new PurchaseIntents.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['marginXName'] = this.marginXName;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['liveTime'] = this.liveTime;
    if (this.marginXTemplate != null) {
      data['marginXTemplate'] = this.marginXTemplate!.toJson();
    }
    if (this.potentialParticipants != null) {
      // data['potentialParticipants'] = this.potentialParticipants!.map((v) => v.toJson()).toList();
    }
    data['maxParticipants'] = this.maxParticipants;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['marginXExpiry'] = this.marginXExpiry;
    data['isNifty'] = this.isNifty;
    data['isBankNifty'] = this.isBankNifty;
    data['isFinNifty'] = this.isFinNifty;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    if (this.sharedBy != null) {
      // data['sharedBy'] = this.sharedBy!.map((v) => v.toJson()).toList();
    }
    if (this.purchaseIntents != null) {
      data['purchaseIntent'] = this.purchaseIntents!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    return data;
  }
}

class MarginXTemplate {
  String? sId;
  String? templateName;
  int? portfolioValue;
  int? entryFee;

  MarginXTemplate({this.sId, this.templateName, this.portfolioValue, this.entryFee});

  MarginXTemplate.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    templateName = json['templateName'];
    portfolioValue = json['portfolioValue'];
    entryFee = json['entryFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['templateName'] = this.templateName;
    data['portfolioValue'] = this.portfolioValue;
    data['entryFee'] = this.entryFee;
    return data;
  }
}

class Participantss {
  String? userId;
  String? boughtAt;
  String? sId;

  Participantss({this.userId, this.boughtAt, this.sId});

  Participantss.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    boughtAt = json['boughtAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['boughtAt'] = this.boughtAt;
    data['_id'] = this.sId;
    return data;
  }
}

class PurchaseIntents {
  String? userId;
  String? date;
  String? sId;

  PurchaseIntents({this.userId, this.date, this.sId});

  PurchaseIntents.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['date'] = this.date;
    data['_id'] = this.sId;
    return data;
  }
}
