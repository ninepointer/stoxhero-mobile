import 'dart:convert';

class TenxTotalPositionDetails {
  num? lots;
  num? brokerage;
  num? gross;
  num? net;

  TenxTotalPositionDetails({
    this.lots,
    this.brokerage,
    this.gross,
    this.net,
  });

  TenxTotalPositionDetails copyWith({
    num? lots,
    num? brokerage,
    num? gross,
    num? net,
  }) {
    return TenxTotalPositionDetails(
      lots: lots ?? this.lots,
      brokerage: brokerage ?? this.brokerage,
      gross: gross ?? this.gross,
      net: net ?? this.net,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lots': lots,
      'brokerage': brokerage,
      'gross': gross,
      'net': net,
    };
  }

  factory TenxTotalPositionDetails.fromMap(Map<String, dynamic> map) {
    return TenxTotalPositionDetails(
      lots: map['lots'] != null ? map['lots'] as num : null,
      brokerage: map['brokerage'] != null ? map['brokerage'] as num : null,
      gross: map['gross'] != null ? map['gross'] as num : null,
      net: map['net'] != null ? map['net'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TenxTotalPositionDetails.fromJson(String source) =>
      TenxTotalPositionDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
