import 'package:stoxhero/src/base/base.dart';

import '../../core/core.dart';
import '../data.dart';

class WalletRepository extends BaseRepository {
  Future<RepoResponse<WalletTransactionsListResponse>> getWalletTransactionsList() async {
    String apiURL = AppUrls.userWalletTransactions;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: WalletTransactionsListResponse.fromJson(response));
  }

  Future<RepoResponse<MyWithdrawalsListResponse>> getMyWithdrawalsTransactionsList() async {
    String apiURL = AppUrls.myWithdrawals;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: MyWithdrawalsListResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> withdrawals(Map<String, dynamic> data) async {
    String apiURL = AppUrls.withdrawal;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<VerifyCouponCodeResponse>> verifyCouponCode(Map<String, dynamic> data) async {
    String apiURL = AppUrls.verifyCouponCode;
    var response = await service.postAuth(path: apiURL, data: data);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VerifyCouponCodeResponse.fromJson(response));
  }
}
