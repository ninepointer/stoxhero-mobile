import 'dart:convert';

class StockTotalPositionDetails {
  num? lots;
  num? brokerage;
  num? gross;
  num? net;
  num? currentvalue;
  num? roi;
  num? pnl;
  StockTotalPositionDetails({
    this.lots,
    this.brokerage,
    this.gross,
    this.net,
    this.currentvalue,
    this.roi,
    this.pnl,
  });

  StockTotalPositionDetails copyWith(
      {num? lots, num? brokerage, num? gross, num? net, num? currentvalue}) {
    return StockTotalPositionDetails(
      lots: lots ?? this.lots,
      brokerage: brokerage ?? this.brokerage,
      gross: gross ?? this.gross,
      net: net ?? this.net,
      currentvalue: currentvalue ?? this.currentvalue,
      roi: roi ?? this.roi,
      pnl: pnl ?? this.pnl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lots': lots,
      'brokerage': brokerage,
      'gross': gross,
      'net': net,
      'currentvalue': currentvalue,
      'roi': roi,
      'pnl': pnl,
    };
  }

  factory StockTotalPositionDetails.fromMap(Map<String, dynamic> map) {
    return StockTotalPositionDetails(
      lots: map['lots'] != null ? map['lots'] as num : null,
      brokerage: map['brokerage'] != null ? map['brokerage'] as num : null,
      gross: map['gross'] != null ? map['gross'] as num : null,
      net: map['net'] != null ? map['net'] as num : null,
      currentvalue:
          map['currentvalue'] != null ? map['currentvalue'] as num : null,
      roi: map['roi'] != null ? map['roi'] as num : null,
      pnl: map['pnl'] != null ? map['pnl'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockTotalPositionDetails.fromJson(String source) =>
      StockTotalPositionDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
