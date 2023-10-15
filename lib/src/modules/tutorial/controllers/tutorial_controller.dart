import 'dart:developer';

import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';

class TutorialBinding implements Bindings {
  @override
  void dependencies() => Get.put(TutorialController());
}

class TutorialController extends BaseController<TutorialRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final selectedTabBarIndex = 0.obs;

  final tutorialList = <TutorialList>[].obs;

  Future loadData() async {
    await getTutorialList();
  }

  void changeTabBarIndex(int val) => selectedTabBarIndex.value = val;

  Future getTutorialList() async {
    isLoading(true);
    try {
      final RepoResponse<TutorialResponse> response = await repository.getTutorialList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tutorialList(response.data?.data ?? []);
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
}
