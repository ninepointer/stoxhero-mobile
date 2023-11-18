import '../../app/app.dart';

class ContestProfileRepository extends BaseRepository {
  Future<RepoResponse<ContestProfileResponse>> getContestProfile(String? id) async {
    String apiURL = AppUrls.contestProfile(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: ContestProfileResponse.fromJson(response));
  }

  Future<RepoResponse<WeeklyTopPerformersListResponse>> getWeeklyTopPerformer() async {
    String apiURL = AppUrls.weeklyTopPerformers;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: WeeklyTopPerformersListResponse.fromJson(response));
  }
}
