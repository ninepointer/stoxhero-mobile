import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class DashboardRepository extends BaseRepository {
  Future<RepoResponse<DashboardReturnSummaryResponse>>
      getDashboardReturnSummary() async {
    String apiURL = AppUrls.returnSummary;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: DashboardReturnSummaryResponse.fromJson(response));
  }

  Future<RepoResponse<DashboardTradeSummaryResponse>> getDashboard(
      String? tradeType, String? timeFame) async {
    String apiURL = AppUrls.performance(tradeType, timeFame);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: DashboardTradeSummaryResponse.fromJson(response));
  }

  Future<RepoResponse<DashboardTradeSummaryResponse>> getDashboardVirtual(
      String? tradeType, String? timeFame) async {
    String apiURL = AppUrls.virtualperformance(tradeType, timeFame);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: DashboardTradeSummaryResponse.fromJson(response));
  }

  Future<RepoResponse<DashboardCarouselResponse>> getDashboardCarousel() async {
    String apiURL = AppUrls.dashboardCarousel;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: DashboardCarouselResponse.fromJson(response));
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
}
