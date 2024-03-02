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

  Future<RepoResponse<GenericResponse>> suggestChanges(
      String id, Map<String, dynamic> data) async {
    String apiURL = AppUrls.suggestchange(id);
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getAdminApproval(String id) async {
    String apiURL = AppUrls.adminapproval(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<CourseOverviewResponse>> getCourseOverview(
      String id) async {
    String apiURL = AppUrls.courseOverView(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CourseOverviewResponse.fromJson(response));
  }

  Future<RepoResponse<InfluencerCourseResponse>> getUserAllCourses() async {
    String apiURL = AppUrls.usercourses;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InfluencerCourseResponse.fromJson(response));
  }

  Future<RepoResponse<CourseOverviewResponse>> getUserCourseOverview(
      String id) async {
    String apiURL = AppUrls.userCoursesOverView(id);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: CourseOverviewResponse.fromJson(response));
  }

  Future<RepoResponse<UserMyCoursesResponse>> getUserMyCourses() async {
    String apiURL = AppUrls.userMycourses;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: UserMyCoursesResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> purchaseCourse(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.deductCourseFee;
    var response = await service.patchAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> ratingCourse(Map<String, dynamic> data,String? courseId) async {
    String apiURL = AppUrls.courseRating(courseId);
    var response = await service.postAuth(path: apiURL,data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
