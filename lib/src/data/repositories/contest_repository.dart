import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class ContestRepository extends BaseRepository {
  Future<RepoResponse<UpComingContestListResponse>> getUpComingContestList() async {
    String apiURL = AppUrls.upComingContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: UpComingContestListResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedContestListResponse>> getCompletedContestList() async {
    String apiURL = AppUrls.completedContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedContestListResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedContestPnlListResponse>> getCompletedContestPnlList() async {
    String apiURL = AppUrls.allContestPnl;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedContestPnlListResponse.fromJson(response));
  }
}
