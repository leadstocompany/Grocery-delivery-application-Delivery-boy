import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';

class MapWebView extends StatefulWidget {
  final String origin; // Current location (lat,lng)
  final String destination; // Destination location (lat,lng)

  MapWebView({required this.origin, required this.destination});

  @override
  _MapWebViewState createState() => _MapWebViewState();
}

class _MapWebViewState extends State<MapWebView> {
  InAppWebViewController? webViewController;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&origin=${widget.origin}&destination=${widget.destination}&travelmode=driving";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios_new)),
          ),
        ),
        title: const Text(
          "Navigate to Destination",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest:
                URLRequest(url: WebUri.uri(Uri.parse(googleMapsUrl))),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStop: (controller, url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          // Loader Overlay
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}
