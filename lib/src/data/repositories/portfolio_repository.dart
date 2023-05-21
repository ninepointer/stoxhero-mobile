import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class PortfolioRepository extends BaseRepository {
  Future<RepoResponse<PortfolioResponse>> getPortfolioList() async {
    String apiURL = AppUrls.myPortfolio;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: PortfolioResponse.fromJson(response));
  }
}
