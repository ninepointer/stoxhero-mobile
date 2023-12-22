import '../../base/base.dart';
import '../../core/core.dart';
import '../data.dart';

class StocksTradingRepository extends BaseRepository {

Future<RepoResponse<StockWatchlistSearchDataResponse>>
      getStockWatchlist(String searchQuery) async {
    String apiURL = AppUrls.StocksDashboardView_watchlist(searchQuery);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(
            data: StockWatchlistSearchDataResponse.fromJson(response));
  }

}