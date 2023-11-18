import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';
import '../models/response/contest_profile_response.dart';


class ContestProfileRepository extends BaseRepository {
  Future<RepoResponse<ContestProfileResponse>> getContestProfile(String? id) async {
    String apiURL = AppUrls.contestProfile(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestProfileResponse.fromJson(response));
  }
}