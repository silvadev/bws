///
/// author: sergio e. lisan (sels@venosyd.com)
///
/// This is a Open Source software, based on GNU GPL v3, backed by Venosyd
/// Consult www.venosyd.com/legal for instructions
///
/// venosyd ©2016
///
/// plugin who watches directories and compile dart to javascript
///
library bws.watcher;

import 'dart:io';
import 'dart:isolate';

import 'package:watcher/watcher.dart';
import 'package:bws/bws_util.dart';

/// flag that indicates if pub build is running
bool isProcessing = false;

/// CLIENT send communication door
SendPort send;

main(args, SendPort client) {
  send = client;
  watchAndCompile();
}

///
/// watch for modifications in the web directory and recompile for use in
/// browsers doesn't have dartvm embedded
///
watchAndCompile() {
  var watcher = new Watcher('web/');
  watcher.events.listen((onData) {
    if (!isProcessing) {
      isProcessing = true;
      sysout('compiling web files, wait until done');
      send.send('[WATCHER] running');

      Process.run('/usr/lib/dart/bin/pub', ['build']).then((ProcessResult result) {
        if (!result.stdout.isEmpty) {
          sysout('web files compiled');
          send.send('[WATCHER] finished');
          //
        } else if (!result.stderr.isEmpty) {
          sysout('web files compilation error: ${result.stderr}');
          send.send('[WATCHER] error');
        }

        isProcessing = false;
      });
    }
  });
}
