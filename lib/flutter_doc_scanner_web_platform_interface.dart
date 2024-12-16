import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_doc_scanner_web_method_channel.dart';

abstract class FlutterDocScannerWebPlatform extends PlatformInterface {
  /// Constructs a FlutterDocScannerWebPlatform.
  FlutterDocScannerWebPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDocScannerWebPlatform _instance = MethodChannelFlutterDocScannerWeb();

  /// The default instance of [FlutterDocScannerWebPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDocScannerWeb].
  static FlutterDocScannerWebPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDocScannerWebPlatform] when
  /// they register themselves.
  static set instance(FlutterDocScannerWebPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
