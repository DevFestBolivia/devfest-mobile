import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/screens/routes.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/widgets/main_button.dart';
import 'package:devfestbolivia/providers/attendees_provider.dart';

class ScannerTab extends StatefulWidget {
  const ScannerTab({Key? key}) : super(key: key);

  @override
  State<ScannerTab> createState() => _ScannerTabState();
}

class _ScannerTabState extends State<ScannerTab> {
  AttendeesProvider? attendeesProvider;
  bool loading = true;

  Barcode? result;
  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    loadReferences(context);
    return Scaffold(
      body: loading ? const CircularProgressIndicator() : renderBody(),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Widget renderBody() {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void loadReferences(BuildContext context) {
    if (!loading) {
      return;
    }
    attendeesProvider = Provider.of<AttendeesProvider>(context);
    loading = false;
  }

  Widget renderQr() {
    return QrImage(
      data: getQrData(),
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  String getQrData() {
    Attendees? attendees = attendeesProvider!.getCurrentUser();
    String qr = attendees != null && attendees.id != null ? attendees.id! : '';
    return qr;
  }

  Widget renderCameraButton() {
    return MainButton(
      onPressed: () => Navigator.pushNamed(context, Routes.CAMERA),
      text: TextStrings.openCamera,
    );
  }
}
