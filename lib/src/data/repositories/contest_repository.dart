import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';
import '../models/response/completed_college_contest_list_response.dart';
import '../models/response/upcoming_college_contest_list_response.dart';

class ContestRepository extends BaseRepository {
  Future<RepoResponse<UpComingContestListResponse>> getUpComingContestList() async {
    String apiURL = AppUrls.upComingContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: UpComingContestListResponse.fromJson(response));
  }

  Future<RepoResponse<LiveContestListResponse>> getLiveContestList() async {
    String apiURL = AppUrls.liveContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: LiveContestListResponse.fromJson(response));
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

  Future<RepoResponse<ContestLeaderboardResponse>> getContestLeaderboardList() async {
    String apiURL = AppUrls.contestLeaderboard;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestLeaderboardResponse.fromJson(response));
  }

  Future<RepoResponse<ContestOrderResponse>> getContestOrderList(String? id) async {
    String apiURL = AppUrls.completedContestOrders(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestOrderResponse.fromJson(response));
  }

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

  Future<RepoResponse<ContestPortfolioResponse>> getContestPortfolio() async {
    String apiURL = AppUrls.contestCreditData;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<ContestWatchListResponse>> getContestWatchList() async {
    String apiURL = AppUrls.contestWatchList;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestWatchListResponse.fromJson(response));
  }

  Future<RepoResponse<ContestPositionListResponse>> getContestPositions() async {
    String apiURL = AppUrls.contestPosition;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestPositionListResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedContestOrdersResponse>> getCompletedContestOrders(String? id) async {
    String apiURL = AppUrls.completedContestOrders(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedContestOrdersResponse.fromJson(response));
  }
}
