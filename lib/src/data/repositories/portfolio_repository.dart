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

  Future<RepoResponse<MyTenxPortfolioResponse>> getMyTenxPortfolioList() async {
    String apiURL = AppUrls.myTenx;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: MyTenxPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<VirtualTradingPortfolioResponse>> getVirtualTradingPortfolioList() async {
    String apiURL = AppUrls.virtualTradingPortfolio;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VirtualTradingPortfolioResponse.fromJson(response));
  }

  Future<RepoResponse<TenxTradingPortfolioMarginDetailsResponse>> getTenXTradingMarginDetailsList(String id) async {
    String apiURL = '${AppUrls.tenx}/$id/${AppUrls.tradeMarginDetails}';
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxTradingPortfolioMarginDetailsResponse.fromJson(response));
  }
}
