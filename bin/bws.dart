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

/// package imports
import 'package:http_server/http_server.dart';

/// parts
part 'bws_staticfiles.dart';

// server ip
final HOST = InternetAddress.ANY_IP_V4;
final DOOR = 8080;

///
/// main loop of the server
///
main() async {
  var server = await HttpServer.bind(HOST, DOOR);
  print("[BWS] SERVER ONLINE at $HOST:$DOOR");

  ///
  /// at this momento, serves only static files
  ///
  await for (var request in server) {
    new StaticFilesProvider().serve(request);
  }
}
