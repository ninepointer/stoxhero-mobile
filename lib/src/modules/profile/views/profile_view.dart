import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../profile_index.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.logout),
            onPressed: () => Get.offAllNamed(AppRoutes.signin),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
