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
/// interface for the providers
///
abstract class Provider {
  /// serve files
  serve(HttpRequest request);
}

///
/// provides basic markup, script and media files
///
class StaticFilesProvider implements Provider {
  //
  static final String _jsFiles = Platform.script.resolve('../build/web/').toFilePath();
  static final String _dartFiles = Platform.script.resolve('../web/').toFilePath();

  /// JavaScript compile sources folder
  final VirtualDirectory _clientJS = new VirtualDirectory(_jsFiles);

  /// Dart souces folder
  final VirtualDirectory _clientDart = new VirtualDirectory(_dartFiles);

  ///
  /// treats with static files to the web client
  ///
  void serve(HttpRequest request) {
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

        print('[BWS] Serving file: ${fileUri.toFilePath()}');
        _clientJS.serveFile(new File(fileUri.toFilePath()), request);
      }
    }
  }
}
