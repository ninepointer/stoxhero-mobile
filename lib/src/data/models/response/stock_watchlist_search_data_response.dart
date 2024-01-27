class StockWatchlistSearchDataResponse {
  String? status;
  List<StockWatchlistSearchData>? data;
  String? message;

  StockWatchlistSearchDataResponse({this.status, this.data, this.message});

  StockWatchlistSearchDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StockWatchlistSearchData>[];
      json['data'].forEach((v) {
        data!.add(new StockWatchlistSearchData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class StockWatchlistSearchData {
  String? sId;
  int? instrumentToken;
  int? exchangeToken;
  String? tradingsymbol;
  String? name;
  int? strike;
  double? tickSize;
  String? instrumentType;
  String? segment;
  String? exchange;
  String? accountType;
  String? lastModifiedBy;
  String? createdBy;
  String? status;
  String? lastModifiedOn;
  String? createdOn;
  int? iV;

  StockWatchlistSearchData(
      {this.sId,
      this.instrumentToken,
      this.exchangeToken,
      this.tradingsymbol,
      this.name,
      this.strike,
      this.tickSize,
      this.instrumentType,
      this.segment,
      this.exchange,
      this.accountType,
      this.lastModifiedBy,
      this.createdBy,
      this.status,
      this.lastModifiedOn,
      this.createdOn,
      this.iV});

  StockWatchlistSearchData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    instrumentToken = json['instrument_token'];
    exchangeToken = json['exchange_token'];
    tradingsymbol = json['tradingsymbol'];
    name = json['name'];
    strike = json['strike'];
    tickSize = json['tick_size'];
    instrumentType = json['instrument_type'];
    segment = json['segment'];
    exchange = json['exchange'];
    accountType = json['accountType'];
    lastModifiedBy = json['lastModifiedBy'];
    createdBy = json['createdBy'];
    status = json['status'];
    lastModifiedOn = json['lastModifiedOn'];
    createdOn = json['createdOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['instrument_token'] = this.instrumentToken;
    data['exchange_token'] = this.exchangeToken;
    data['tradingsymbol'] = this.tradingsymbol;
    data['name'] = this.name;
    data['strike'] = this.strike;
    data['tick_size'] = this.tickSize;
    data['instrument_type'] = this.instrumentType;
    data['segment'] = this.segment;
    data['exchange'] = this.exchange;
    data['accountType'] = this.accountType;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['createdOn'] = this.createdOn;
    data['__v'] = this.iV;
    return data;
  }
}
