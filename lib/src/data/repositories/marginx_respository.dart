import 'package:stoxhero/src/data/models/response/live_marginx_list_response.dart';
import 'package:stoxhero/src/data/models/response/upcoming_marginx_list_response.dart';

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
}
