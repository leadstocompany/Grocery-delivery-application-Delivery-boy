import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class PdfViewerPage extends StatefulWidget {
  final String assetPath;

  PdfViewerPage({required this.assetPath});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String? localPath; // Make localPath nullable

  @override
  void initState() {
    super.initState();
    _loadPdfFromAsset();
  }

  Future<void> _loadPdfFromAsset() async {
    try {
      final byteData = await rootBundle.load(widget.assetPath);
      final file = File('${(await getTemporaryDirectory()).path}/terms.pdf');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      setState(() {
        localPath = file.path; // Assign the path to localPath
      });
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white, title: Text('Terms and Conditions')),
      body: localPath == null
          ? Center(
              child: CircularProgressIndicator()) // Show loader while loading
          : PDFView(
              filePath: localPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: true,
            ),
    );
  }
}
