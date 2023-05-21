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
}
