import '../../app/app.dart';
import '../models/response/upcoming_college_contest_list_response.dart';

class CollegeContestRepository extends BaseRepository {
  Future<RepoResponse<CollegeContestLeaderboardResponse>> getCollegeContestLeaderboardList() async {
    String apiURL = AppUrls.collegeContestLeaderboard;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CollegeContestLeaderboardResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedContestPnlListResponse>> getCompletedContestPnlList() async {
    String apiURL = AppUrls.allContestPnl;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedContestPnlListResponse.fromJson(response));
  }

  Future<RepoResponse<ContestOrderResponse>> getContestOrderList(String? id) async {
    String apiURL = AppUrls.completedContestOrders(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestOrderResponse.fromJson(response));
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

  Future<RepoResponse<TradingWatchlistResponse>> getInternshipWatchlist() async {
    String apiURL = AppUrls.tradingInstrumentWatchlist;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingWatchlistResponse.fromJson(response));
  }

  Future<RepoResponse<ContestPortfolioResponse>> getContestPortfolio(String? id) async {
    String apiURL = AppUrls.contestCreditData(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<TradingWatchlistResponse>> getContestWatchList(
      bool? isNifty, bool? isBankNifty, bool? isFinNifty) async {
    String apiURL = AppUrls.contestInstrumentWatchList(isNifty, isBankNifty, isFinNifty);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingWatchlistResponse.fromJson(response));
  }

  Future<RepoResponse<ContestPositionListResponse>> getContestPositions(String? id) async {
    String apiURL = AppUrls.contestPosition(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestPositionListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> placeContestOrder(Map<String, dynamic> data) async {
    String apiURL = AppUrls.contestPlacingOrder;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<TradingInstrumentListResponse>> searchInstruments(
    String? value,
    bool? isNifty,
    bool? isBankNifty,
    bool? isFinNifty,
  ) async {
    String apiURL = AppUrls.contestsTradingInstruments(isNifty, isBankNifty, isFinNifty);
    var query = {'search': value, 'page': 1, 'size': 20};
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingInstrumentListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> removeInstrument(int id) async {
    String apiURL = '${AppUrls.inActiveInstrument}/$id';
    var response = await service.patchAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> addInstrument(Map<String, dynamic> data) async {
    String apiURL = AppUrls.addInstrument;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<StockIndexInstrumentListResponse>> getStockIndexInstrumentsList() async {
    String apiURL = AppUrls.stockIndex;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: StockIndexInstrumentListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> purchaseContest(Map<String, dynamic> data) async {
    String apiURL = AppUrls.purchaseContest;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<InstrumentLivePriceListResponse>> getInstrumentLivePrices() async {
    String apiURL = AppUrls.getliveprice;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InstrumentLivePriceListResponse.fromJson(response));
  }

  Future<RepoResponse> generateCollegeContestOtp(Map<String, dynamic> data) async {
    String apiURL = AppUrls.generateCollegeContestOtp;
    var response = await service.post(path: apiURL, data: data);
    return response is APIException ? RepoResponse(error: response) : RepoResponse(data: response);
  }

  Future<RepoResponse> validateCollegeContestOtp(Map<String, dynamic> data) async {
    String apiURL = AppUrls.confirmCollegeContestOtp;
    var response = await service.post(path: apiURL, data: data);
    return response is APIException ? RepoResponse(error: response) : RepoResponse(data: response);
  }

  Future<RepoResponse<GenericResponse>> getShareContest(String? id) async {
    String apiURL = AppUrls.shareContest(id);
    var response = await service.putAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getNotified(String? id) async {
    String apiURL = AppUrls.getNotified(id);
    var response = await service.putAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> participate(String? id) async {
    String apiURL = AppUrls.participate(id);
    var response = await service.putAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
