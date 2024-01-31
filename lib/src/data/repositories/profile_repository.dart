import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class ProfileRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> updateUserDetails(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.updateUserDetails;
    var response = await service.patchAuthFormData(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<VerifyKYCGenrateOTPResponse>> verifyKYCOtpGenrate(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.kycVerificationGenrateOtp;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VerifyKYCGenrateOTPResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> verifyKYCOtpVerify(
      Map<String, dynamic> data) async {
    String apiURL = AppUrls.kycVerificationVerifyOtp;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  // Future<RepoResponse<VerifyKYCGenrateOTPResponse>>
  //     getKYCGenrateOtpDetails() async {
  //   String apiURL = AppUrls.kycVerificationGenrateOtp;
  //   var response = await service.getAuth(path: apiURL);
  //   return response is APIException
  //       ? RepoResponse(error: response)
  //       : RepoResponse(data: VerifyKYCGenrateOTPResponse.fromJson(response));
  // }
}
