import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class MarginXRepository extends BaseRepository {
  Future<RepoResponse<UpComingMarginXListResponse>> getUpComingMarginXList() async {
    String apiURL = AppUrls.upComingMarginX;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: UpComingMarginXListResponse.fromJson(response));
  }

  Future<RepoResponse<LiveMarginxListResponse>> getLiveMarginXList() async {
    String apiURL = AppUrls.liveMarginx;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: LiveMarginxListResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedMarginxListResponse>> getCompletedMarginXList() async {
    String apiURL = AppUrls.completedMarginx;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedMarginxListResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedMarginXOrdersResponse>> getCompletedMarginXOrders(String? id) async {
    String apiURL = AppUrls.completedMarginXOrders(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedMarginXOrdersResponse.fromJson(response));
  }

  Future<RepoResponse<TradingPositionListResponse>> getMarginXPositions(String? id) async {
    String apiURL = AppUrls.marginXPosition(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingPositionListResponse.fromJson(response));
  }

  Future<RepoResponse<TradingInstrumentListResponse>> searchInstruments(
    String? value,
    bool? isNifty,
    bool? isBankNifty,
    bool? isFinNifty,
  ) async {
    String apiURL = AppUrls.marginXTradingInstruments(
      isNifty,
      isBankNifty,
      isFinNifty,
    );
    var query = {'search': value, 'page': 1, 'size': 20};
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingInstrumentListResponse.fromJson(response));
  }

  Future<RepoResponse<TradingWatchlistResponse>> getMarginXWatchlist(
      bool? isNifty, bool? isBankNifty, bool? isFinNifty) async {
    String apiURL = AppUrls.marginXInstrumentWatchList(isNifty, isBankNifty, isFinNifty);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingWatchlistResponse.fromJson(response));
  }

  Future<RepoResponse<InstrumentLivePriceListResponse>> getInstrumentLivePrices() async {
    String apiURL = AppUrls.getliveprice;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InstrumentLivePriceListResponse.fromJson(response));
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

  Future<RepoResponse<StockIndexInstrumentListResponse>> getStockIndexInstrumentsList() async {
    String apiURL = AppUrls.stockIndex;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StockIndexInstrumentListResponse.fromJson(response));
  }

  Future<RepoResponse<MarginXPortfolioResponse>> getMarginXPortfolioDetails(String? subId) async {
    String apiURL = AppUrls.marginXCreditData(subId);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: MarginXPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> paperPlaceOrder(Map<String, dynamic> data) async {
    String apiURL = AppUrls.marginXPlaceOrder;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> purchaseMarginX(Map<String, dynamic> data) async {
    String apiURL = AppUrls.purchaseMarginX;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getShareMarginX(String? id) async {
    String apiURL = AppUrls.shareMarginX(id);
    var response = await service.putAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<MarginRequiredResponse>> getMarginRequired(Map<String, dynamic> data) async {
    String apiURL = AppUrls.marginRequired;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: MarginRequiredResponse.fromJson(response));
  }

  Future<RepoResponse<StopLossExecutedOrdersListResponse>> getStopLossExecutedOrder(String? id) async {
    String apiURL = AppUrls.marginXStopLossExecutedOrder(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StopLossExecutedOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<StopLossPendingOrdersListResponse>> getStopLossPendingOrder(String? id) async {
    String apiURL = AppUrls.marginXStopLossPendingOrder(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StopLossPendingOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getStopLossPendingCancelOrder(String id) async {
    String apiURL = AppUrls.marginXStopLossPendingCancelOrder(id);
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

  Future<RepoResponse<CompletedMarginXOrdersResponse>> getMarginXTodayOrdersList(String? id) async {
    String apiURL = AppUrls.marginXTodayOrders(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedMarginXOrdersResponse.fromJson(response));
  }
}
