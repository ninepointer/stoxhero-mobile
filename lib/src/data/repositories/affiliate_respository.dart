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

  Future<RepoResponse<MyAffiliateRefferalsListResponse>>
      getMyAffiliateReferralsData(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.getMyAffiliateReferrals;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: MyAffiliateRefferalsListResponse.fromJson(response));
  }

  Future<RepoResponse<MyAffiliateTransctionListResponse>>
      getMyAffiliateTranscationList(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.getMyAffiliateTransactionList;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: MyAffiliateTransctionListResponse.fromJson(response));
  }

  Future<RepoResponse<AffiliateOverViewResponse>>
      getAffiliateOverViewList() async {
    String apiURL = AppUrls.getAffiliateOverView;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: AffiliateOverViewResponse.fromJson(response));
  }

  Future<RepoResponse<Last30DaysAffiliateDataResponse>>
      getAffiliateLast30DaysDetails() async {
    String apiURL = AppUrls.getAffiliateLast30daysData;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: Last30DaysAffiliateDataResponse.fromJson(response));
  }
}
