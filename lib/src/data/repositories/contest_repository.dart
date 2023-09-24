import 'package:stoxhero/src/data/models/response/contest_instrument_list_response.dart';

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

  Future<RepoResponse<ContestPortfolioResponse>> getContestPortfolio(String? id) async {
    String apiURL = AppUrls.contestCreditData(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<ContestWatchListResponse>> getContestWatchList(
      bool? isNifty, bool? isBankNifty, bool? isFinNifty) async {
    String apiURL = AppUrls.contestWatchList(isNifty, isBankNifty, isFinNifty);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestWatchListResponse.fromJson(response));
  }

  Future<RepoResponse<ContestPositionListResponse>> getContestPositions(String? id) async {
    String apiURL = AppUrls.contestPosition(id);
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

  Future<RepoResponse<GenericResponse>> placeOrder(Map<String, dynamic> data) async {
    String apiURL = AppUrls.contestPlacingOrder;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<ContestInstrumentListResponse>> searchInstruments(String? value) async {
    String apiURL = AppUrls.tenxTradingSearchInstruments;
    var query = {'search': value, 'page': 1, 'size': 20};
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestInstrumentListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> removeInstrument(int id) async {
    String apiURL = '${AppUrls.inActiveInstrument}/$id';
    var response = await service.patchAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
