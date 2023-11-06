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

  Future<RepoResponse<GenericResponse>> careerApply(Map<String, dynamic> data) async {
    String apiURL = AppUrls.careerApply;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<CollegeListResponse>> getCollegeList() async {
    String apiURL = AppUrls.collegeList;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CollegeListResponse.fromJson(response));
  }
}
