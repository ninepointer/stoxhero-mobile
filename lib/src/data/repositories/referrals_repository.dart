import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class ReferralsRepository extends BaseRepository {
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

  Future<RepoResponse<GenericResponse>> getMyReferrals() async {
    String apiURL = AppUrls.referralsMyRank;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
