import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class TenxTradingRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> postPurchaseIntent(Map<String, dynamic> data) async {
    String apiURL = AppUrls.purchaseIntent;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<TradingInstrumentListResponse>> searchInstruments(String? value) async {
    String apiURL = AppUrls.tradingInstruments;
    var query = {'search': value, 'page': 1, 'size': 20};
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingInstrumentListResponse.fromJson(response));
  }

  Future<RepoResponse<TenxTradingActiveResponse>> getTenxActiveSubscriptions() async {
    String apiURL = AppUrls.tenxActive;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxTradingActiveResponse.fromJson(response));
  }

  Future<RepoResponse<TradingWatchlistResponse>> getTenxWatchlist() async {
    String apiURL = AppUrls.tradingInstrumentWatchlist;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingWatchlistResponse.fromJson(response));
  }

  Future<RepoResponse<TenxTradingPositionListResponse>> getTenxPositions(String id) async {
    String apiURL = '${AppUrls.tenx}/$id/trade/pnl';
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxTradingPositionListResponse.fromJson(response));
  }

  Future<RepoResponse<InstrumentLivePriceListResponse>> getInstrumentLivePrices() async {
    String apiURL = AppUrls.getliveprice;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InstrumentLivePriceListResponse.fromJson(response));
  }

  Future<RepoResponse<TenxTradingPortfolioDetailsResponse>> getTenxPortfolioDetails(
      String subId) async {
    String apiURL = '${AppUrls.tenx}/$subId/trade/marginDetail';
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxTradingPortfolioDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> placeOrder(Map<String, dynamic> data) async {
    String apiURL = AppUrls.tenxTradingPlacingOrder;
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

  Future<RepoResponse<GenericResponse>> purchaseSubscription(Map<String, dynamic> data) async {
    String apiURL = AppUrls.purchaseSubscription;
    var response = await service.patchAuth(path: apiURL, data: data);
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
}
