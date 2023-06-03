import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class TenxTradingRepository extends BaseRepository {
  Future<RepoResponse<TenxTradingActiveResponse>> getTenxActiveSubscriptions() async {
    String apiURL = AppUrls.tenxActive;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxTradingActiveResponse.fromJson(response));
  }
}
