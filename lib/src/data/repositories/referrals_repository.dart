import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class ReferralsRepository extends BaseRepository {
  Future<RepoResponse<EarningsResponse>> getMyEarnings() async {
    String apiURL = AppUrls.earnings;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: EarningsResponse.fromJson(response));
  }

  Future<RepoResponse<ActiveReferralResponse>> getActiveReferrals() async {
    String apiURL = AppUrls.referralsActive;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ActiveReferralResponse.fromJson(response));
  }

  Future<RepoResponse<ReferralsLeaderboardResponse>> getReferralsLeaderboard() async {
    String apiURL = AppUrls.referralsLeaderboard;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ReferralsLeaderboardResponse.fromJson(response));
  }

  Future<RepoResponse<MyReferralsResponse>> getMyReferrals(String userId) async {
    String apiURL = '${AppUrls.myReferrals}/$userId';
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: MyReferralsResponse.fromJson(response));
  }
}
