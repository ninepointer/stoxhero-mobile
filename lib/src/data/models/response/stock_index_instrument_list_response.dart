class StockIndexInstrumentListResponse {
  String? message;
  List<StockIndexInstrument>? data;

  StockIndexInstrumentListResponse({this.message, this.data});

  StockIndexInstrumentListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <StockIndexInstrument>[];
      json['data'].forEach((v) {
        data!.add(new StockIndexInstrument.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(data) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockIndexInstrument {
  String? sId;
  String? displayName;
  String? exchange;
  String? instrumentSymbol;
  String? status;
  int? instrumentToken;
  String? createdBy;
  String? lastModifiedBy;
  String? accountType;
  int? exchangeSegment;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;

  StockIndexInstrument(
      {this.sId,
      this.displayName,
      this.exchange,
      this.instrumentSymbol,
      this.status,
      this.instrumentToken,
      this.createdBy,
      this.lastModifiedBy,
      this.accountType,
      this.exchangeSegment,
      this.createdOn,
      this.lastModifiedOn,
      this.iV});

  StockIndexInstrument.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    displayName = json['displayName'];
    exchange = json['exchange'];
    instrumentSymbol = json['instrumentSymbol'];
    status = json['status'];
    instrumentToken = json['instrumentToken'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    accountType = json['accountType'];
    exchangeSegment = json['exchangeSegment'];
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['displayName'] = this.displayName;
    data['exchange'] = this.exchange;
    data['instrumentSymbol'] = this.instrumentSymbol;
    data['status'] = this.status;
    data['instrumentToken'] = this.instrumentToken;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['accountType'] = this.accountType;
    data['exchangeSegment'] = this.exchangeSegment;
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    return data;
  }
}
