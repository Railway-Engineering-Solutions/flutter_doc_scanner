import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner_platform_interface.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDocScannerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDocScannerPlatform {
  dynamic pdfResult;
  int? pdfPage;

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
  @override
  Future<dynamic> getScanDocuments(int page) => Future.value();
  @override
  Future<dynamic> getScannedDocumentAsImages({
    required int page,
    required String imageFormat,
    required double quality,
    bool useAutomaticSinglePictureProcessing = false,
  }) =>
      Future.value();
  @override
  Future<dynamic> getScannedDocumentAsPdf(int page) async {
    pdfPage = page;
    return pdfResult;
  }

  @override
  Future<dynamic> getScanDocumentsUri(int page) => Future.value();
}

void main() {
  final initialPlatform = FlutterDocScannerPlatform.instance;
  tearDown(() {
    FlutterDocScannerPlatform.instance = initialPlatform;
  });
  test('MethodChannelFlutterDocScanner is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDocScanner>());
  });
  test('getPlatformVersion', () async {
    FlutterDocScannerPlatform.instance = MockFlutterDocScannerPlatform();
    expect(await FlutterDocScanner().getPlatformVersion(), '42');
  });
  for (final entry in <String, dynamic>{
    'String path': '/tmp/scan.pdf',
    'file URI String': 'file:///tmp/scan%20document.pdf',
    'Map with metadata': {'pdfUri': 'file:///tmp/scan.pdf', 'pageCount': 2},
    'List of paths': ['/tmp/scan.pdf', '/tmp/second.pdf'],
    'empty List': <String>[],
    'cancellation': null,
  }.entries) {
    test('PDF scan preserves legacy ${entry.key} result', () async {
      final fakePlatform = MockFlutterDocScannerPlatform()
        ..pdfResult = entry.value;
      FlutterDocScannerPlatform.instance = fakePlatform;
      expect(await FlutterDocScanner().getScannedDocumentAsPdf(page: 2),
          entry.value);
      expect(fakePlatform.pdfPage, 2);
    });
  }
  test('PDF scan rejects invalid page before calling the platform', () async {
    final fakePlatform = MockFlutterDocScannerPlatform();
    FlutterDocScannerPlatform.instance = fakePlatform;
    await expectLater(FlutterDocScanner().getScannedDocumentAsPdf(page: 0),
        throwsArgumentError);
    expect(fakePlatform.pdfPage, isNull);
  });
}
