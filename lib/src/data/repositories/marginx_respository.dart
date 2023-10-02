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

  Future<RepoResponse<MarginXTradingPositionResponse>> getMarginXPositions(String? id) async {
    String apiURL = AppUrls.marginXPosition(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: MarginXTradingPositionResponse.fromJson(response));
  }

  Future<RepoResponse<TradingInstrumentListResponse>> searchInstruments(
    String? value,
    bool? isNifty,
    bool? isBankNifty,
    bool? isFinNifty,
  ) async {
    String apiURL = AppUrls.marginXTradingInstruments(isNifty, isBankNifty, isFinNifty);
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
    String apiURL = AppUrls.purchaseContest;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
