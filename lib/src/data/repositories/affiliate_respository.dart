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

  Future<RepoResponse<MyAffiliateRefferalsListResponse>> getAffiliateSignupData(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.getAffiliateSignup;
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
  // Future<RepoResponse<AffiliateRefferralsResponse>>
  //     getAffiliateSignupData() async {
  //   String apiURL = AppUrls.getAffiliateSignup;
  //   var response = await service.getAuth(path: apiURL);
  //   return response is APIException
  //       ? RepoResponse(error: response)
  //       : RepoResponse(data: AffiliateRefferralsResponse.fromJson(response));
  // }
}
