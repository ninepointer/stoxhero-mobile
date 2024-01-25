import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class StocksTradingRepository extends BaseRepository {
  Future<RepoResponse<StockWatchlistSearchDataResponse>> getStockWatchlist(
      String searchQuery) async {
    String apiURL = AppUrls.StocksDashboardView_watchlist(searchQuery);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: StockWatchlistSearchDataResponse.fromJson(response));
  }

  Future<RepoResponse<ReadSettingResponse>> readSetting() async {
    String apiURL = AppUrls.readSetting;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ReadSettingResponse.fromJson(response[0]));
  }

  Future<RepoResponse<StockIndexInstrumentListResponse>>
      getStockIndexInstrumentsList() async {
    String apiURL = AppUrls.stockIndex;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: StockIndexInstrumentListResponse.fromJson(response));
  }

  // Future<RepoResponse<GenericResponse>> removeInstrument(int id) async {
  //   String apiURL = '${AppUrls.inActiveInstrument}/$id';
  //   var response = await service.patchAuth(path: apiURL);
  //   return response is APIException
  //       ? RepoResponse(error: response)
  //       : RepoResponse(data: GenericResponse.fromJson(response));
  // }
  Future<RepoResponse<GenericResponse>> addStock(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.addStock;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<EquityInstrumentDetailsResponse>>
      getEquityInstrumentDetails(Map<String, dynamic> data) async {
    String apiURL = AppUrls.getEquityInstrumentDetails;
    var response = await service.getAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: EquityInstrumentDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> removeInstrument(
      int instrumentToken) async {
    String apiURL = AppUrls.RemoveStockCard(instrumentToken);
    var response = await service.patchAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> stockPlaceOrder(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.stockOrderPlace;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<StockMarginRequiredResponse>> getMarginRequired(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.stockMarginRequired;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StockMarginRequiredResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getStopLossPendingCancelOrder(
      String id) async {
    String apiURL = AppUrls.stocksStopLossPendingCancelOrder(id);
    var response = await service.patchAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getStopLossEditOrder(
      String? id, Map<String, dynamic> data) async {
    String apiURL = AppUrls.stopLossEditOrder(id);
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<StocksTradingPortfolioResponse>>
      getStocksTradingPortfolio() async {
    String apiURL = AppUrls.stocksTradingPortfolio;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StocksTradingPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<StocksPositionsListResponse>> getstocksPositions() async {
    String apiURL = AppUrls.stockTradePosition;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StocksPositionsListResponse.fromJson(response));
  }

  Future<RepoResponse<StocksHoldingsListResponse>> getstocksHoldings() async {
    String apiURL = AppUrls.stockTradeHolding;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StocksHoldingsListResponse.fromJson(response));
  }

  Future<RepoResponse<VirtualStopLossPendingOrderResponse>>
      getVirtualStopLossPendingOrder(String id) async {
    String apiURL = AppUrls.virtualPendingStopLoss(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: VirtualStopLossPendingOrderResponse.fromJson(response));
  }

  Future<RepoResponse<StocksExcuatedOrderResponse>>
      getStocksStopLossExcuatedOrder(String id) async {
    String apiURL = AppUrls.stocksExcuatedOrder(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StocksExcuatedOrderResponse.fromJson(response));
  }

  Future<RepoResponse<StocksPendingOrderResponse>>
      getStocksStopLossPendingOrder(String id) async {
    String apiURL = AppUrls.stocksPendingOrder(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StocksPendingOrderResponse.fromJson(response));
  }

  Future<RepoResponse<StocksTodayOrderResponse>>
      getStockTradeTodaysOrdersList() async {
    String apiURL = AppUrls.stockTradeTodaysOrders;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StocksTodayOrderResponse.fromJson(response));
  }

  Future<RepoResponse<StocksFundsMarginResponse>> getStockFundsMargin() async {
    String apiURL = AppUrls.stockFundsMargin;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StocksFundsMarginResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> pendingOrderModify(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.pendingOrderModify;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
