import '../../app/app.dart';

class InternshipRespository extends BaseRepository {
  Future<RepoResponse<AnalyticsOverviewDetailsResponse>> getInternshipAnalyticsOverview(String? id) async {
    String apiURL = AppUrls.internshipOverview(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsOverviewDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsDateWiseDetailsResponse>> getInternshipAnalyticsDateWisePnLOverviewDetails(
    String? id,
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.internshipDateWisePNL(id);
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsDateWiseDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsMonthlyPnLOverviewDetailsResponse>> getInternshipAnalyticsMonthlyPnLOverviewDetails(
      String? id) async {
    String apiURL = AppUrls.internshipMonthlyPNL(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsMonthlyPnLOverviewDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<InternshipBatchResponse>> getInternshipBatchDetails() async {
    String apiURL = AppUrls.internshipBatch;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InternshipBatchResponse.fromJson(response));
  }

  Future<RepoResponse<InternshipBatchPortfolioResponse>> getInternshipBatchPortfolioDetails(String? id) async {
    String apiURL = AppUrls.internshipBatchPortfolio(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InternshipBatchPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<TradingInstrumentListResponse>> searchInstruments(String? value) async {
    String apiURL = AppUrls.tradingInstruments;
    var query = {'search': value, 'page': 1, 'size': 20};
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingInstrumentListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> placeOrder(Map<String, dynamic> data) async {
    String apiURL = AppUrls.internshipPlaceOrder;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> addInstrument(Map<String, dynamic> data) async {
    String apiURL = AppUrls.addInstrument;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> removeInstrument(int id) async {
    String apiURL = '${AppUrls.inActiveInstrument}/$id';
    var response = await service.patchAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> paperPlaceOrder(Map<String, dynamic> data) async {
    String apiURL = AppUrls.internshipPlaceOrder;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<StockIndexInstrumentListResponse>> getStockIndexInstrumentsList() async {
    String apiURL = AppUrls.stockIndex;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StockIndexInstrumentListResponse.fromJson(response));
  }

  Future<RepoResponse<InstrumentLivePriceListResponse>> getInstrumentLivePrices() async {
    String apiURL = AppUrls.getliveprice;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InstrumentLivePriceListResponse.fromJson(response));
  }

  Future<RepoResponse<TradingWatchlistResponse>> getInternshipWatchlist() async {
    String apiURL = AppUrls.tradingInstrumentWatchlist;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingWatchlistResponse.fromJson(response));
  }

  Future<RepoResponse<TradingPositionListResponse>> getInternshipPositions(String? id) async {
    String apiURL = AppUrls.internshipPosition(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingPositionListResponse.fromJson(response));
  }

  Future<RepoResponse<InternshipOrdersListResponse>> getInternshipAllOrdersList() async {
    String apiURL = AppUrls.internshipAllOrders;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InternshipOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<InternshipOrdersListResponse>> getInternshipTodayOrdersList() async {
    String apiURL = AppUrls.internshipTodayOrders;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InternshipOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<MarginRequiredResponse>> getMarginRequired(Map<String, dynamic> data) async {
    String apiURL = AppUrls.marginRequired;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: MarginRequiredResponse.fromJson(response));
  }

  Future<RepoResponse<StopLossExecutedOrdersListResponse>> getStopLossExecutedOrder(String? id) async {
    String apiURL = AppUrls.internshipStopLossExecutedOrder(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StopLossExecutedOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<StopLossPendingOrdersListResponse>> getStopLossPendingOrder(String? id) async {
    String apiURL = AppUrls.internshipStopLossPendingOrder(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StopLossPendingOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getStopLossPendingCancelOrder(String id) async {
    String apiURL = AppUrls.internshipStopLossPendingCancelOrder(id);
    var response = await service.patchAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> pendingOrderModify(Map<String, dynamic> data) async {
    String apiURL = AppUrls.pendingOrderModify;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getStopLossEditOrder(String? id, Map<String, dynamic> data) async {
    String apiURL = AppUrls.stopLossEditOrder(id);
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<InternshipCertificateResponse>> getInternshipCertificate() async {
    String apiURL = AppUrls.internshipCertificate;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InternshipCertificateResponse.fromJson(response));
  }
}
