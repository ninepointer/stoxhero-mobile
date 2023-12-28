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
}
