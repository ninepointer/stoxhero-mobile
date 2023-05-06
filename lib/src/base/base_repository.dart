import 'package:get/instance_manager.dart';
import '../data/data.dart';

class BaseRepository {
  NetworkService get service => GetInstance().find<NetworkService>();
}
