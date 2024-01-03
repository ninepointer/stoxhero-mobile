import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stoxhero/firebase_options.dart';
import 'package:webengage_flutter/webengage_flutter.dart';
import 'src/app/app.dart';

const bool isProd = false;
const bool useTestToken = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WebEngagePlugin _webEngagePlugin = new WebEngagePlugin();
  print('webengage$_webEngagePlugin');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(App());
}
