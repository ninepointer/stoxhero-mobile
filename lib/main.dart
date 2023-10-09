import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'src/app/app.dart';

const bool isProd = true;
// const bool isProd = true;
const bool useTestToken = true;
void main() async {
  await GetStorage.init();
  runApp(App());
}
