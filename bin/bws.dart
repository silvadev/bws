///
/// author: sergio e. lisan (sels@venosyd.com)
///
/// This is a Open Source software, based on GNU GPL v3, backed by Venosyd
/// Consult www.venosyd.com/legal for instructions
///
/// venosyd ©2016
///
/// Basic Web Server in Dart
///
library bws.server;

/// imports
import 'dart:io';
import 'dart:async';
import 'dart:isolate';

/// package imports
import 'package:http_server/http_server.dart';
import 'package:bws/bws_util.dart';

/// parts
part 'bws_staticfiles.dart';

/// server ip
final HOST = InternetAddress.ANY_IP_V4;

/// server port
final PORT = 8080;

/// isolate door for receive from other isolates
ReceivePort r1;

/// stream sended to isolates to communicate with this one
SendPort s1;

///
/// main loop of the server
///
main() async {
  var server = await HttpServer.bind(HOST, PORT);
  sysout("SERVER ONLINE at $HOST:$PORT");

  // comunicates with other services at the same time
  r1 = new ReceivePort();
  s1 = r1.sendPort;

  // PLUGINS LIST OVER HERE
  // 1. watcher directory service
  StaticFilesProvider sfp = new StaticFilesProvider();

  /// at this momento, serves only static files
  await for (var request in server) {
    sfp.staticFileLoad(request);
  }
}
