import 'package:stoxhero/src/data/models/response/dashboard_return_summary_response.dart';

import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class DashboardRepository extends BaseRepository {
  Future<RepoResponse<DashboardReturnSummaryResponse>> getDashboardReturnSummary() async {
    String apiURL = AppUrls.returnSummary;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: DashboardReturnSummaryResponse.fromJson(response));
  }

  Future<RepoResponse<DashboardResponse>> getDashboard() async {
    String apiURL = AppUrls.performance;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: DashboardResponse.fromJson(response));
  }

  Future<RepoResponse<DashboardCarouselResponse>> getDashboardCarousel() async {
    String apiURL = AppUrls.dashboardCarousel;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: DashboardCarouselResponse.fromJson(response));
  }
}
