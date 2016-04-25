///
/// author: sergio e. lisan (sels@venosyd.com)
///
/// This is a Open Source software, based on GNU GPL v3, backed by Venosyd
/// Consult www.venosyd.com/legal for instructions
///
/// venosyd ©2016
///
/// utilities functions
///
library bws.util;

///
/// prints a default format message for BWS console outputs
///
sysout(message) {
  DateTime now = new DateTime.now();
  print('[BWS ${now.year}-${now.month}-${now.day}] ' + message);
}
