class ContestPositionListResponse {
  String? message;
  List<ContestPositionList>? data;

  ContestPositionListResponse({this.message, this.data});

  ContestPositionListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ContestPositionList>[];
      json['data'].forEach((v) {
        data!.add(new ContestPositionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContestPositionList {
  CId? iId;
  int? amount;
  num? brokerage;
  int? lots;
  int? lastaverageprice;

  ContestPositionList({this.iId, this.amount, this.brokerage, this.lots, this.lastaverageprice});

  ContestPositionList.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new CId.fromJson(json['_id']) : null;
    amount = json['amount'];
    brokerage = json['brokerage'];
    lots = json['lots'];
    lastaverageprice = json['lastaverageprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['amount'] = this.amount;
    data['brokerage'] = this.brokerage;
    data['lots'] = this.lots;
    data['lastaverageprice'] = this.lastaverageprice;
    return data;
  }
}

class CId {
  String? symbol;
  String? product;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  String? exchange;

  CId(
      {this.symbol,
      this.product,
      this.instrumentToken,
      this.exchangeInstrumentToken,
      this.exchange});

  CId.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    product = json['product'];
    instrumentToken = json['instrumentToken'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    exchange = json['exchange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['product'] = this.product;
    data['instrumentToken'] = this.instrumentToken;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['exchange'] = this.exchange;
    return data;
  }
}
