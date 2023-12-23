import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class AffiliateRespository extends BaseRepository {
  Future<RepoResponse<AffiliateSummaryResponse>> getAffiliateDashboardSummary(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.getAffiliateSummary;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AffiliateSummaryResponse.fromJson(response));
  }

  // Future<RepoResponse<AffiliateSummaryResponse>> getVirtualTradingDateWiseAnalyticsDetails(
  //   Map<String, dynamic> query,
  // ) async {
  //   String apiURL = AppUrls.virtualTradingDateWiseAnalytics;
  //   var response = await service.getAuth(path: apiURL, query: query);
  //   return response is APIException
  //       ? RepoResponse(error: response)
  //       : RepoResponse(data: AffiliateSummaryResponse.fromJson(response));
  // }
}
