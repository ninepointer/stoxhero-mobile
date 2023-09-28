import '../../app/app.dart';
import '../models/response/completed_college_contest_list_response.dart';
import '../models/response/upcoming_college_contest_list_response.dart';

class CollegeContestRepository extends BaseRepository {
  Future<RepoResponse<CollegeContestLeaderboardResponse>> getCollegeContestLeaderboardList() async {
    String apiURL = AppUrls.collegeContestLeaderboard;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CollegeContestLeaderboardResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedCollegeContestListResponse>> getCompletedCollegeContestList() async {
    String apiURL = AppUrls.completedCollegeContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedCollegeContestListResponse.fromJson(response));
  }

  Future<RepoResponse<UpComingCollegeContestListResponse>> getUpComingCollegeContestList() async {
    String apiURL = AppUrls.upComingCollegeContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: UpComingCollegeContestListResponse.fromJson(response));
  }

  Future<RepoResponse<LiveCollegeContestListResponse>> getLiveCollegeContestList() async {
    String apiURL = AppUrls.liveCollegeContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: LiveCollegeContestListResponse.fromJson(response));
  }
}
