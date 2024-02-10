import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';
import '../models/response/upcoming_college_contest_list_response.dart';
// import '../models/response/lastPaidTestZone_top_performer_list_response.dart';

class ContestRepository extends BaseRepository {
  Future<RepoResponse<UpComingContestListResponse>>
      getUpComingContestList() async {
    String apiURL = AppUrls.upComingContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: UpComingContestListResponse.fromJson(response));
  }

  Future<RepoResponse<IndexLivePriceListResponse>> getIndexLivePrices() async {
    String apiURL = AppUrls.getIndexLivePrice;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: IndexLivePriceListResponse.fromJson(response));
  }

  Future<RepoResponse<ContestStopLossPendingOrderResponse>>
      getContestStopLossPendingOrder(String id) async {
    String apiURL = AppUrls.contestPendingStopLoss(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: ContestStopLossPendingOrderResponse.fromJson(response));
  }

  Future<RepoResponse<LiveContestListResponse>> getLiveContestList() async {
    String apiURL = AppUrls.liveContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: LiveContestListResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedContestListResponse>>
      getCompletedContestList() async {
    String apiURL = AppUrls.completedContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedContestListResponse.fromJson(response));
  }

  Future<RepoResponse<LastPaidTestZoneTopPerformerListResponse>>
      getPaidContestChampionList() async {
    String apiURL = AppUrls.contestChampionList;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: LastPaidTestZoneTopPerformerListResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedContestPnlListResponse>>
      getCompletedContestPnlList() async {
    String apiURL = AppUrls.allContestPnl;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: CompletedContestPnlListResponse.fromJson(response));
  }

  Future<RepoResponse<DayWiseContestPnlResponse>> getDayWiseContestPnl(
      String? id) async {
    String apiURL = AppUrls.dayWiseContestPnl(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: DayWiseContestPnlResponse.fromJson(response));
  }

  Future<RepoResponse<ContestLeaderboardResponse>>
      getContestLeaderboardList() async {
    String apiURL = AppUrls.contestLeaderboard;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestLeaderboardResponse.fromJson(response));
  }

  Future<RepoResponse<ContestOrderResponse>> getContestOrderList(
      String? id) async {
    String apiURL = AppUrls.completedContestOrders(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestOrderResponse.fromJson(response));
  }

  Future<RepoResponse<ContestResultPageResponse>> getContestResultPageData(
      String? id) async {
    String apiURL = AppUrls.contestResultPage(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestResultPageResponse.fromJson(response));
  }

  Future<RepoResponse<CollegeContestLeaderboardResponse>>
      getCollegeContestLeaderboardList() async {
    String apiURL = AppUrls.collegeContestLeaderboard;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: CollegeContestLeaderboardResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedCollegeContestListResponse>>
      getCompletedCollegeContestList() async {
    String apiURL = AppUrls.completedCollegeContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: CompletedCollegeContestListResponse.fromJson(response));
  }

  Future<RepoResponse<UpComingCollegeContestListResponse>>
      getUpComingCollegeContestList() async {
    String apiURL = AppUrls.upComingCollegeContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: UpComingCollegeContestListResponse.fromJson(response));
  }

  Future<RepoResponse<LiveCollegeContestListResponse>>
      getLiveCollegeContestList() async {
    String apiURL = AppUrls.liveCollegeContests;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: LiveCollegeContestListResponse.fromJson(response));
  }

  Future<RepoResponse<ContestPortfolioResponse>> getContestPortfolio(
      String? id) async {
    String apiURL = AppUrls.contestCreditData(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<TradingWatchlistResponse>> getContestWatchList(
      bool? isNifty, bool? isBankNifty, bool? isFinNifty) async {
    String apiURL =
        AppUrls.contestInstrumentWatchList(isNifty, isBankNifty, isFinNifty);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingWatchlistResponse.fromJson(response));
  }

  Future<RepoResponse<TradingPositionListResponse>> getContestPositions(
      String? id) async {
    String apiURL = AppUrls.contestPosition(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TradingPositionListResponse.fromJson(response));
  }

  Future<RepoResponse<ContestOrderResponse>> getCompletedContestOrders(
      String? id) async {
    String apiURL = AppUrls.completedContestOrders(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestOrderResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> placeContestOrder(
      Map<String, dynamic> data) async {
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
    String apiURL =
        AppUrls.contestsTradingInstruments(isNifty, isBankNifty, isFinNifty);
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

  Future<RepoResponse<GenericResponse>> addInstrument(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.addInstrument;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<StockIndexInstrumentListResponse>>
      getStockIndexInstrumentsList() async {
    String apiURL = AppUrls.stockIndex;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: StockIndexInstrumentListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> purchaseContest(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.purchaseContest;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<InstrumentLivePriceListResponse>>
      getInstrumentLivePrices() async {
    String apiURL = AppUrls.getliveprice;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: InstrumentLivePriceListResponse.fromJson(response));
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

  Future<RepoResponse<CompletedContestLeaderboardListResponse>>
      getCompletedContestLeaderboardList(String? id) async {
    String apiURL = AppUrls.completedContestLeaderboard(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: CompletedContestLeaderboardListResponse.fromJson(response));
  }

  Future<RepoResponse<MarginRequiredResponse>> getMarginRequired(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.marginRequired;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: MarginRequiredResponse.fromJson(response));
  }

  Future<RepoResponse<StopLossExecutedOrdersListResponse>>
      getStopLossExecutedOrder(String? id) async {
    String apiURL = AppUrls.contestStopLossExecutedOrder(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: StopLossExecutedOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<StopLossPendingOrdersListResponse>>
      getStopLossPendingOrder(String? id) async {
    String apiURL = AppUrls.contestStopLossPendingOrder(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: StopLossPendingOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getStopLossPendingCancelOrder(
      String id) async {
    String apiURL = AppUrls.contestStopLossPendingCancelOrder(id);
    var response = await service.patchAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> pendingOrderModify(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.pendingOrderModify;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getStopLossEditOrder(
      String? id, Map<String, dynamic> data) async {
    String apiURL = AppUrls.stopLossEditOrder(id);
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<FeaturedContestResponse>> getFeaturedContest() async {
    String apiURL = AppUrls.featuredContest;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: FeaturedContestResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> featuredParticipate(String? id) async {
    String apiURL = AppUrls.participate(id);
    var response = await service.putAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<ReadSettingResponse>> readSetting() async {
    String apiURL = AppUrls.readSetting;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ReadSettingResponse.fromJson(response[0]));
  }
}
