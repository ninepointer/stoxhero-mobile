import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stoxhero/src/data/models/response/contest_profile_response.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app.dart';

class ContestProfileBinding implements Bindings {
  @override
  void dependencies() => Get.put(ContestProfileController());
}

class ContestProfileController extends BaseController<ContestProfileRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final contestProfileDataList = <ContestProfile>[].obs;
  final contestProfileData = ContestProfile().obs;
  

  Future getContestProfileData (String? id) async {
    final RepoResponse<ContestProfileResponse> response = await repository.getContestProfile(id);
    try{
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          contestProfileDataList(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    
  }

  num getArenasPlayed (){
    int arenasPlayed = 0;
    arenasPlayed = contestProfileDataList.length;
    return arenasPlayed;
  }

  num getArenasWon (){
    int arenasWon = 0;
    contestProfileDataList.forEach((contest) {
      if(contest.payout!>0){
        arenasWon+=1;
      }
    });
    return arenasWon;
  }

  num getEarnings (){
    num earnings = 0;
     contestProfileDataList.forEach((contest) {
        if(contest.payout!>0){
          earnings+=contest.finalPayout!;
        }
     });


    return earnings;
  }


  num getStrikeRate() {
    num strikeRate = 0;
    num contestsWon =  getArenasWon();
    num totalContests = getArenasPlayed();
    strikeRate = contestsWon/totalContests*100;
    return strikeRate;
  }
}
