class DashboardResponse {
  String? status;
  List<Dashboard>? data;

  DashboardResponse({this.status, this.data});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] == null) {
      data = <Dashboard>[];
      json['data'].forEach((v) {
        data!.add(new Dashboard.fromJson(v));
        return data;
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data == null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dashboard {
  num? totalGPNL;
  num? totalBrokerage;
  num? totalNPNL;
  num? totalTrades;
  num? maxProfit;
  num? maxProfitDay;
  num? maxLoss;
  String? maxLossDay;
  num? profitDays;
  num? lossDays;
  num? totalTradingDays;
  num? totalMarketDays;
  num? maxProfitStreak;
  num? maxLossStreak;
  num? averageProfit;
  num? averageLoss;
  num? portfolio;
  num? maxProfitDayProfitPercent;
  num? maxLossDayLossPercent;

  Dashboard(
      {this.totalGPNL,
      this.totalBrokerage,
      this.totalNPNL,
      this.totalTrades,
      this.maxProfit,
      this.maxProfitDay,
      this.maxLoss,
      this.maxLossDay,
      this.profitDays,
      this.lossDays,
      this.totalTradingDays,
      this.totalMarketDays,
      this.maxProfitStreak,
      this.maxLossStreak,
      this.averageProfit,
      this.averageLoss,
      this.portfolio,
      this.maxProfitDayProfitPercent,
      this.maxLossDayLossPercent});

  Dashboard.fromJson(Map<String, dynamic> json) {
    totalGPNL = json['totalGPNL'];
    totalBrokerage = json['totalBrokerage'];
    totalNPNL = json['totalNPNL'];
    totalTrades = json['totalTrades'];
    maxProfit = json['maxProfit'];
    maxProfitDay = json['maxProfitDay'];
    maxLoss = json['maxLoss'];
    maxLossDay = json['maxLossDay'];
    profitDays = json['profitDays'];
    lossDays = json['lossDays'];
    totalTradingDays = json['totalTradingDays'];
    totalMarketDays = json['totalMarketDays'];
    maxProfitStreak = json['maxProfitStreak'];
    maxLossStreak = json['maxLossStreak'];
    averageProfit = json['averageProfit'];
    averageLoss = json['averageLoss'];
    portfolio = json['portfolio'];
    maxProfitDayProfitPercent = json['maxProfitDayProfitPercent'];
    maxLossDayLossPercent = json['maxLossDayLossPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalGPNL'] = this.totalGPNL;
    data['totalBrokerage'] = this.totalBrokerage;
    data['totalNPNL'] = this.totalNPNL;
    data['totalTrades'] = this.totalTrades;
    data['maxProfit'] = this.maxProfit;
    data['maxProfitDay'] = this.maxProfitDay;
    data['maxLoss'] = this.maxLoss;
    data['maxLossDay'] = this.maxLossDay;
    data['profitDays'] = this.profitDays;
    data['lossDays'] = this.lossDays;
    data['totalTradingDays'] = this.totalTradingDays;
    data['totalMarketDays'] = this.totalMarketDays;
    data['maxProfitStreak'] = this.maxProfitStreak;
    data['maxLossStreak'] = this.maxLossStreak;
    data['averageProfit'] = this.averageProfit;
    data['averageLoss'] = this.averageLoss;
    data['portfolio'] = this.portfolio;
    data['maxProfitDayProfitPercent'] = this.maxProfitDayProfitPercent;
    data['maxLossDayLossPercent'] = this.maxLossDayLossPercent;
    return data;
  }
}

// class DashboardResponse {
//   String? status;
//   List<Dashboard>? data;

//   DashboardResponse({this.status, this.data});

//   DashboardResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Dashboard>[];
//       json['data'].forEach((v) {
//         data!.add(new Dashboard.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Dashboard {
//   int? totalTenXPortfolioValue;
//   TenxData? tenxData;
//   VirtualData? virtualData;
//   double? contestReturn;
//   double? tenxReturn;

//   Dashboard(
//       {this.totalTenXPortfolioValue,
//       this.tenxData,
//       this.virtualData,
//       this.contestReturn,
//       this.tenxReturn});

//   Dashboard.fromJson(Map<String, dynamic> json) {
//     totalTenXPortfolioValue = json['totalTenXPortfolioValue'];
//     tenxData = json['tenxData'] != null ? new TenxData.fromJson(json['tenxData']) : null;
//     virtualData =
//         json['virtualData'] != null ? new VirtualData.fromJson(json['virtualData']) : null;
//     contestReturn = json['contestReturn'];
//     tenxReturn = json['tenxReturn'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['totalTenXPortfolioValue'] = this.totalTenXPortfolioValue;
//     if (this.tenxData != null) {
//       data['tenxData'] = this.tenxData!.toJson();
//     }
//     if (this.virtualData != null) {
//       data['virtualData'] = this.virtualData!.toJson();
//     }
//     data['contestReturn'] = this.contestReturn;
//     data['tenxReturn'] = this.tenxReturn;
//     return data;
//   }
// }

// class TenxData {
//   Id? iId;
//   String? date;
//   double? npnl;
//   int? portfolio;

//   TenxData({this.iId, this.date, this.npnl, this.portfolio});

//   TenxData.fromJson(Map<String, dynamic> json) {
//     iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
//     date = json['date'];
//     npnl = json['npnl'];
//     portfolio = json['portfolio'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.iId != null) {
//       data['_id'] = this.iId!.toJson();
//     }
//     data['date'] = this.date;
//     data['npnl'] = this.npnl;
//     data['portfolio'] = this.portfolio;
//     return data;
//   }
// }

// class Id {
//   String? tradeTime;
//   String? subscriptionId;

//   Id({this.tradeTime, this.subscriptionId});

//   Id.fromJson(Map<String, dynamic> json) {
//     tradeTime = json['trade_time'];
//     subscriptionId = json['subscriptionId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['trade_time'] = this.tradeTime;
//     data['subscriptionId'] = this.subscriptionId;
//     return data;
//   }
// }

// class VirtualData {
//   Null? nId;
//   double? totalGpnl;
//   double? totalBrokerage;
//   int? numberOfTrades;
//   Null? portfolio;
//   double? npnl;

//   VirtualData(
//       {this.nId,
//       this.totalGpnl,
//       this.totalBrokerage,
//       this.numberOfTrades,
//       this.portfolio,
//       this.npnl});

//   VirtualData.fromJson(Map<String, dynamic> json) {
//     nId = json['_id'];
//     totalGpnl = json['total_gpnl'];
//     totalBrokerage = json['total_brokerage'];
//     numberOfTrades = json['number_of_trades'];
//     portfolio = json['portfolio'];
//     npnl = json['npnl'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.nId;
//     data['total_gpnl'] = this.totalGpnl;
//     data['total_brokerage'] = this.totalBrokerage;
//     data['number_of_trades'] = this.numberOfTrades;
//     data['portfolio'] = this.portfolio;
//     data['npnl'] = this.npnl;
//     return data;
//   }
// }
