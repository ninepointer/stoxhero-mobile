import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class PortfolioBinding implements Bindings {
  @override
  void dependencies() => Get.put(PortfolioController());
}

class PortfolioController extends BaseController<PortfolioRepository> {
  final isLoading = false.obs;

  final portfoliList = <Portfolio>[].obs;
  final myTenxPortfolioList = <MyTenxPortfolio>[].obs;
  final virtualPortfolio = VirtualTradingPortfolio().obs;

  Future loadData() async {
    isLoading(true);
    await getMyTenxPortfolioList();
    await getVirtualTradingPortfolioList();
    isLoading(false);
  }

  Color getValueColor(dynamic value) {
    if (value != null) {
      if (value is String) {
        if (value.contains('-')) {
          return AppColors.danger;
        } else if (value == '0') {
          return AppColors.success;
        }
      } else {
        num number = value is int || value is double ? value : num.parse(value);
        if (number > 0) {
          return AppColors.success;
        } else if (number < 0) {
          return AppColors.danger;
        } else if (number == 0) {
          return AppColors.success;
        }
      }
    }
    return AppColors.grey;
  }

  Future getPortfolioList() async {
    isLoading(true);
    try {
      final RepoResponse<PortfolioResponse> response = await repository.getPortfolioList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          portfoliList(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getMyTenxPortfolioList() async {
    isLoading(true);
    try {
      final RepoResponse<MyTenxPortfolioResponse> response =
          await repository.getMyTenxPortfolioList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          myTenxPortfolioList(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getVirtualTradingPortfolioList() async {
    isLoading(true);
    try {
      final RepoResponse<VirtualTradingPortfolioResponse> response =
          await repository.getVirtualTradingPortfolioList();
      if (response.data != null) {
        virtualPortfolio(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }
}
