class DashboardTradeSummaryResponse {
  String? status;
  DashboardTradeSummary? data;

  DashboardTradeSummaryResponse({this.status, this.data});

  DashboardTradeSummaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DashboardTradeSummary.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DashboardTradeSummary {
  num? totalGPNL;
  num? totalBrokerage;
  num? totalNPNL;
  int? totalTrades;
  num? maxProfit;
  String? maxProfitDay;
  num? maxLoss;
  String? maxLossDay;
  int? profitDays;
  int? lossDays;
  int? totalTradingDays;
  int? totalMarketDays;
  int? maxProfitStreak;
  int? maxLossStreak;
  num? averageProfit;
  num? averageLoss;
  int? portfolio;
  num? maxProfitDayProfitPercent;
  num? maxLossDayLossPercent;
  int? totalContests;
  int? participatedContests;

  DashboardTradeSummary(
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
      this.maxLossDayLossPercent,
      this.totalContests,
      this.participatedContests});

  DashboardTradeSummary.fromJson(Map<String, dynamic> json) {
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
    totalContests = json['totalContests'];
    participatedContests = json['participatedContests'];
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
    data['totalContests'] = this.totalContests;
    data['participatedContests'] = this.participatedContests;
    return data;
  }
}
