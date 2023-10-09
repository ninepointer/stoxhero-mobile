import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class VirtualTradingRepository extends BaseRepository {
  Future<RepoResponse<InstrumentLivePriceListResponse>> getInstrumentLivePrices() async {
    String apiURL = AppUrls.getliveprice;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InstrumentLivePriceListResponse.fromJson(response));
  }

  Future<RepoResponse<VirtualTradingPortfolioResponse>> getVirtualTradingPortfolio() async {
    String apiURL = AppUrls.virtualTradingPortfolio;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VirtualTradingPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<TradingWatchlistResponse>> getVirtualTradingWatchlist() async {
    String apiURL = AppUrls.tradingInstrumentWatchlist;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingWatchlistResponse.fromJson(response));
  }

  Future<RepoResponse<VirtualTradingPositionListResponse>> getVirtualPositions() async {
    String apiURL = AppUrls.paperTradePosition;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VirtualTradingPositionListResponse.fromJson(response));
  }

  Future<RepoResponse<TradingInstrumentListResponse>> searchInstruments(String? value) async {
    String apiURL = AppUrls.tradingInstruments;
    var query = {'search': value, 'page': 1, 'size': 20};
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingInstrumentListResponse.fromJson(response));
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
    String apiURL = AppUrls.paperTradePlacingOrder;
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
}
