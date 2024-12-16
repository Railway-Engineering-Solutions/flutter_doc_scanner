import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_doc_scanner_web/flutter_doc_scanner_web.dart';
import 'package:flutter_doc_scanner_web/flutter_doc_scanner_web_platform_interface.dart';
import 'package:flutter_doc_scanner_web/flutter_doc_scanner_web_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDocScannerWebPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDocScannerWebPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterDocScannerWebPlatform initialPlatform = FlutterDocScannerWebPlatform.instance;

  test('$MethodChannelFlutterDocScannerWeb is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDocScannerWeb>());
  });

  test('getPlatformVersion', () async {
    FlutterDocScannerWeb flutterDocScannerWebPlugin = FlutterDocScannerWeb();
    MockFlutterDocScannerWebPlatform fakePlatform = MockFlutterDocScannerWebPlatform();
    FlutterDocScannerWebPlatform.instance = fakePlatform;

    expect(await flutterDocScannerWebPlugin.getPlatformVersion(), '42');
  });
}
