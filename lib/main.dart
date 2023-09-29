import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'src/app/app.dart';

const bool isProd = false;
const bool useTestToken = true;

void main() async {
  await GetStorage.init();
  runApp(App());
}
