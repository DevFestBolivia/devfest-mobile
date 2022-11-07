import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScannerTab extends StatefulWidget {
  const ScannerTab({super.key});

  @override
  State<ScannerTab> createState() => _ScannerTabState();
}

class _ScannerTabState extends State<ScannerTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? cameraScanResult = await scanner.scan();
      if (cameraScanResult != null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(cameraScanResult));
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
