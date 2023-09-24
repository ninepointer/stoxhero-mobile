import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class AnalyticsRepository extends BaseRepository {
  Future<RepoResponse<AnalyticsOverviewDetailsResponse>>
      getVirtualTradingAnalyticsOverviewDetails() async {
    String apiURL = AppUrls.virtualTradingAnalyticsOverView;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsOverviewDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsOverviewDetailsResponse>>
      getTenxTradingAnalyticsOverviewDetails() async {
    String apiURL = AppUrls.tenxTradingAnalyticsOverView;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsOverviewDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsOverviewDetailsResponse>>
      getInfinityTradingAnalyticsOverviewDetails() async {
    String apiURL = AppUrls.infinityTradingAnalyticsOverView;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsOverviewDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsDateWiseDetailsResponse>> getVirtualTradingDateWiseAnalyticsDetails(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.virtualTradingDateWiseAnalytics;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsDateWiseDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsDateWiseDetailsResponse>> getTenxTradingDateWiseAnalyticsDetails(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.tenxTradingDateWiseAnalytics;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsDateWiseDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsDateWiseDetailsResponse>> getInfinityTradingDateWiseAnalyticsDetails(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.infinityTradingDateWiseAnalytics;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsDateWiseDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsExpectedPnLOverviewDetailsResponse>>
      getVirtualAnalyticsExpectedPnLOverviewDetails() async {
    String apiURL = AppUrls.analyticsExpectedPnL;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsExpectedPnLOverviewDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsExpectedPnLOverviewDetailsResponse>>
      getTenXAnalyticsExpectedPnLOverviewDetails() async {
    String apiURL = AppUrls.analyticsExpectedPnL;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsExpectedPnLOverviewDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsExpectedPnLOverviewDetailsResponse>>
      getInfinityAnalyticsExpectedPnLOverviewDetails() async {
    String apiURL = AppUrls.analyticsExpectedPnL;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsExpectedPnLOverviewDetailsResponse.fromJson(response));
  }

  Future<RepoResponse<AnalyticsMonthlyPnLOverviewDetailsResponse>>
      getVirtualAnalyticsMonthlyPnLOverviewDetails() async {
    String apiURL = AppUrls.analyticsVirtualMonthlyPnL;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AnalyticsMonthlyPnLOverviewDetailsResponse.fromJson(response));
  }
}
