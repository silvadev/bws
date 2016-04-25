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
part of bws.server;

///
/// provides basic markup, script and media files. builds the code when
/// seeks modifications and wait for conclusion to realize the request.
///
class StaticFilesProvider {
  //
  static final String _jsFiles = Platform.script.resolve('../build/web/').toFilePath();
  static final String _dartFiles = Platform.script.resolve('../web/').toFilePath();

  /// JavaScript compile sources folder
  final VirtualDirectory _clientJS = new VirtualDirectory(_jsFiles);

  /// Dart souces folder
  final VirtualDirectory _clientDart = new VirtualDirectory(_dartFiles);

  /// during the process of building, the requests are blocked
  /// this one stores the request to process later the building
  HttpRequest requestEnqueued;

  /// flag that indicates if pub build is running
  bool buildRunning = false;

  /// constructor of the plugin, calls for directory watcher changes for
  /// recompiling the code
  StaticFilesProvider() {
    Isolate.spawnUri(new Uri(path: '../lib/bws_watcher.dart'), [], s1);
    r1.where(validateWatcherMessage).listen(processWatcherMessage);
  }

  /// functions which opens door to the static file processing
  /// service
  void staticFileLoad(HttpRequest request) {
    if (!buildRunning) {
      _serve(request);
    } else {
      requestEnqueued = request;
    }
  }

  /// verifies if the message is from WATCHER isolate
  validateWatcherMessage(sended) => sended is String && sended.startsWith('[WATCHER]');

  /// process message from WATCHER isolate
  processWatcherMessage(sended) {
    buildRunning = sended.contains('running');
    if (!buildRunning && requestEnqueued != null) {
      _serve(requestEnqueued);
      requestEnqueued = null;
    }
  }

  ///
  /// treats with static files to the web client
  ///
  void _serve(HttpRequest request) {
    if (request.uri.path == '/') {
      request.response.redirect(Uri.parse('/index.html'));
    } else {
      var fileRequested = request.uri.path.substring(1);

      // adds a .html to simulate apache shortcuts
      if (!fileRequested.contains('.')) {
        fileRequested += '.html';
      }

      // Dart directioned request handler
      if (request.headers.value(HttpHeaders.USER_AGENT).contains('(Dart)')) {
        var fileUri = new Uri.file(_dartFiles).resolve(fileRequested);
        _clientDart.serveFile(new File(fileUri.toFilePath()), request);
      }
      // JavaScript directioned request handler
      else {
        if (fileRequested.endsWith('.dart')) {
          fileRequested += '.js';
        }
        var fileUri = new Uri.file(_jsFiles).resolve(fileRequested);

        sysout('Serving file: ${fileUri.toFilePath()}');
        _clientJS.serveFile(new File(fileUri.toFilePath()), request);
      }
    }
  }
}
