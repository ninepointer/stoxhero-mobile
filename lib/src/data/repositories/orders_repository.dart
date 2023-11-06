import 'package:stoxhero/src/data/data.dart';

import '../../base/base.dart';
import '../../core/core.dart';

class OrdersRepository extends BaseRepository {
  Future<RepoResponse<InfinityTradeOrdersListResponse>> getInfinityTradeTodaysOrdersList() async {
    String apiURL = AppUrls.infinityTradeTodaysOrders;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InfinityTradeOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<InfinityTradeOrdersListResponse>> getInfinityTradeAllOrdersList() async {
    String apiURL = AppUrls.infinityTradeAllOrders;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: InfinityTradeOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<TenxTradeOrdersListResponse>> getTenxTradeTodaysOrdersList(String? subscriptionId) async {
    String apiURL = AppUrls.tenxTradeTodaysOrders(subscriptionId);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxTradeOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<TenxTradeOrdersListResponse>> getTenxTradeAllOrdersList(
      String? subId, String? subscribedOn, String? expiredOn) async {
    String apiURL = AppUrls.tenxTradeAllOrders(subId, subscribedOn, expiredOn);
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenxTradeOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<VirtualTradeOrdersListResponse>> getVirtualTradeTodaysOrdersList() async {
    String apiURL = AppUrls.paperTradeTodaysOrders;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VirtualTradeOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<VirtualTradeOrdersListResponse>> getVirtualTradeAllOrdersList() async {
    String apiURL = AppUrls.paperTradeAllOrders;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: VirtualTradeOrdersListResponse.fromJson(response));
  }

  Future<RepoResponse<TenXSubscriptionResponse>> getTenXSubscriptionList() async {
    String apiURL = AppUrls.tenxSubscription;
    var response = await service.getAuth(path: apiURL);
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: TenXSubscriptionResponse.fromJson(response));
  }
}
