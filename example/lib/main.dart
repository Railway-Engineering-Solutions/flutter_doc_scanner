import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner_web/flutter_doc_scanner_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic _scannedDocuments;

  Future<void> scanDocument() async {
    dynamic scannedDocuments;
    try {
      if (kIsWeb) {
        scannedDocuments = await FlutterDocScannerWeb().getScanDocumentsWeb(
          context,
          appBarTitle: "Crop Document",
          captureButtonText: "Capture Image",
          cropButtonText: "Crop & Save",
          cropPdfButtonText: "Crop & PDF",
          width: 400,
          height: 400,
        );
      } else {
        print("This plugin only support for web");
      }
    } on PlatformException {
      scannedDocuments = 'Failed to get scanned documents.';
    }
    print(scannedDocuments.toString());
    if (!mounted) return;
    setState(() {
      _scannedDocuments = scannedDocuments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Scanner Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Document Scanner example app'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _scannedDocuments != null
                    ? Text(_scannedDocuments.toString())
                    : const Text("No Documents Scanned"),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    scanDocument();
                  },
                  child: const Text("Scan Documents"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

