import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../core/core.dart';

class SocketService extends GetxController {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  late io.Socket socket;

  Future<void> initSocket() async {
    try {
      socket = io.io(AppUrls.baseURL, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
      }).connect();

      socket.onConnect((_) {
        var userId = AppStorage.getUserDetails().sId;
        print('Socket : Connected : $userId');
        socket.emit('userId', userId);
        socket.emit('user-ticks', userId);
        // socket.emit('equity-watchlist', userId);
      });

      socket.onAny((event, data) {
        // print('Socket : Event : $event with data: $data');
      });
         
      socket.onConnectError((err) => print('Socket : onConnectError : $err'));

      socket.onDisconnect((_) => print('Socket : onDisconnect'));

      socket.onError((err) => print('Socket : onError : $err'));
    } catch (e) {
      print('Socket : Error Initializing Socket : $e');
    }
  }
}
