import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class CareerRepository extends BaseRepository {
  Future<RepoResponse<CareerResponse>> getCareerList(String? type) async {
    String apiURL = AppUrls.careers(type);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CareerResponse.fromJson(response));
  }

  Future<RepoResponse> generateCareerOtp(Map<String, dynamic> data) async {
    String apiURL = AppUrls.generateCareerOtp;
    var response = await service.post(path: apiURL, data: data);
    return response is APIException ? RepoResponse(error: response) : RepoResponse(data: response);
  }

  Future<RepoResponse> validateCareerOtp(Map<String, dynamic> data) async {
    String apiURL = AppUrls.confirmCareerOtp;
    var response = await service.post(path: apiURL, data: data);
    return response is APIException ? RepoResponse(error: response) : RepoResponse(data: response);
  }
}
