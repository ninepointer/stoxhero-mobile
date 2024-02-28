import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class CourseRespository extends BaseRepository {
  Future<RepoResponse<InfluencerCourseResponse>> getInfluencerPublishCourse(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.publishCourse;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InfluencerCourseResponse.fromJson(response));
  }

  Future<RepoResponse<InfluencerCourseResponse>> getInfluencerUnpublishCourse(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.unpublishCourse;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InfluencerCourseResponse.fromJson(response));
  }

  Future<RepoResponse<InfluencerCourseResponse>>
      getInfluencerPendingAdminApprovalCourse(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.pendingadminapprovalCourse;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InfluencerCourseResponse.fromJson(response));
  }

  Future<RepoResponse<InfluencerCourseResponse>>
      getInfluencerAwaitingApprovalCourse(
    Map<String, dynamic> query,
  ) async {
    String apiURL = AppUrls.awaitingapprovalCourse;
    var response = await service.getAuth(path: apiURL, query: query);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InfluencerCourseResponse.fromJson(response));
  }
}
