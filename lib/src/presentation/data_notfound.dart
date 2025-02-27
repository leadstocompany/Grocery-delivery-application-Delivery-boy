import 'package:flutter/material.dart';

class DataNotFound extends StatelessWidget {
  final String message;
  final String imagePath;
  final double width;
  final double height;

  const DataNotFound({
    Key? key,
    this.message = "No Data Available",
    required this.imagePath,
    this.width = 200,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              width: width,
              height: height,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 0),
          Text(
            message,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
