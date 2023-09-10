import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class TutorialRepository extends BaseRepository {
  Future<RepoResponse<TutorialResponse>> getTutorialList() async {
    String apiURL = AppUrls.tutorial;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TutorialResponse.fromJson(response));
  }
}
