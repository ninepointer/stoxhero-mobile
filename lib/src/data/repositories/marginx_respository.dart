import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class MarginXRepository extends BaseRepository {
  Future<RepoResponse<UpComingMarginXListResponse>> getUpComingMarginXList() async {
    String apiURL = AppUrls.upComingMarginX;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: UpComingMarginXListResponse.fromJson(response));
  }

  Future<RepoResponse<LiveMarginxListResponse>> getLiveMarginXList() async {
    String apiURL = AppUrls.liveMarginx;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: LiveMarginxListResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedMarginxListResponse>> getCompletedMarginXList() async {
    String apiURL = AppUrls.completedMarginx;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedMarginxListResponse.fromJson(response));
  }

  Future<RepoResponse<CompletedMarginXOrdersResponse>> getCompletedMarginXOrders(String? id) async {
    String apiURL = AppUrls.completedMarginXOrders(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CompletedMarginXOrdersResponse.fromJson(response));
  }
}
