import 'package:flutter/material.dart';

class ScannerTab extends StatefulWidget {
  const ScannerTab({Key? key}) : super(key: key);

  @override
  State<ScannerTab> createState() => _ScannerTabState();
}

class _ScannerTabState extends State<ScannerTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Scanner'),
      ),
    );
  }
}
