import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class ProfileRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> updateUserDetails(Map<String, dynamic> data) async {
    String apiURL = AppUrls.updateUserDetails;
    var response = await service.patchAuthFormData(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
