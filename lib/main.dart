import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'src/app/app.dart';

bool isProd = false;

void main() async {
  await GetStorage.init();
  runApp(App());
}
