class StockMarginRequiredResponse {
  String? status;
  String? margin;

  StockMarginRequiredResponse({this.status, this.margin});

  StockMarginRequiredResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    margin = json['margin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['margin'] = this.margin;
    return data;
  }
}
