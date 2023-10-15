import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';
import '../models/response/tenx_my_active_subscribed_list_response.dart';
import '../models/response/tenx_my_expired_subscription_list_response.dart';

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

  Future<RepoResponse<TenxTradingPortfolioDetailsResponse>> getTenxPortfolioDetails(String subId) async {
    String apiURL = '${AppUrls.tenx}/$subId/trade/marginDetail';
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxTradingPortfolioDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> placeTenxTradingOrder(Map<String, dynamic> data) async {
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

  Future<RepoResponse<TenXSubscriptionResponse>> getTenXSubscriptionList() async {
    String apiURL = AppUrls.tenxSubscription;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenXSubscriptionResponse.fromJson(response));
  }

  Future<RepoResponse<CountTradingDaysResponse>> getTenxCountTradingDays(String id) async {
    String apiURL = AppUrls.tenxCountTradingDays(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CountTradingDaysResponse.fromJson(response));
  }

  Future<RepoResponse<TenxSubscriberCountListResponse>> getTenxSubcriberCount(String? id) async {
    String apiURL = AppUrls.tenxSubscriberCount(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxSubscriberCountListResponse.fromJson(response));
  }

  Future<RepoResponse<TenxMyActiveSubscribedListResponse>> getTenxMyActiveSubscribed() async {
    String apiURL = AppUrls.tenxMyActiveSubscribed;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxMyActiveSubscribedListResponse.fromJson(response));
  }

  Future<RepoResponse<TenxMyExpiredSubscriptionListResponse>> getTenxMyExpiredSubscription() async {
    String apiURL = AppUrls.tenxMyExpiredSubscription;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxMyExpiredSubscriptionListResponse.fromJson(response));
  }

  Future<RepoResponse<TenxLeaderboardListResponse>> getTenxLeaderboard() async {
    String apiURL = AppUrls.tenxleaderboard;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxLeaderboardListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> tenxRenewSubscription(Map<String, dynamic> data) async {
    String apiURL = AppUrls.tenxRenew;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
