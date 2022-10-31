import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    loadReferences(context);
    return Scaffold(
      body: loading ? const CircularProgressIndicator() :renderBody(),
    );
  }

  Widget renderBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          renderQr(),
          Platform.isAndroid || Platform.isIOS
              ? renderCameraButton()
              : Container()
        ],
      ),
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
