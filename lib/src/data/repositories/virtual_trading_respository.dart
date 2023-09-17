import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class VirtualTradingRepository extends BaseRepository {
  Future<RepoResponse<VirtualTradingPortfolioResponse>> getVirtualTradingPortfolio() async {
    String apiURL = AppUrls.virtualTradingPortfolio;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VirtualTradingPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<VirtualTradingWatchListResponse>> getVirtualTradingWatchlist() async {
    String apiURL = AppUrls.tenxTradingWatchlist;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VirtualTradingWatchListResponse.fromJson(response));
  }

  Future<RepoResponse<StockIndexResponse>> getStockIndex() async {
    String apiURL = AppUrls.stockIndex;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StockIndexResponse.fromJson(response));
  }

  Future<RepoResponse<VirtualTradingPositionListResponse>> getVirtualPositions() async {
    String apiURL = AppUrls.paperTradePosition;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VirtualTradingPositionListResponse.fromJson(response));
  }

  Future<RepoResponse<VirtualTradingInstrumentListResponse>> searchInstruments(
      String? value) async {
    String apiURL = AppUrls.tenxTradingSearchInstruments;
    var query = {'search': value, 'page': 1, 'size': 20};
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VirtualTradingInstrumentListResponse.fromJson(response));
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
}
