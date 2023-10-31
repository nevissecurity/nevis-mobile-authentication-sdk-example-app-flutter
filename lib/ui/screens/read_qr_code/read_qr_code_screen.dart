// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/read_qr_code_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/read_qr_code_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/qr_scanner_overlay.dart';

class ReadQrCodeScreen extends StatefulWidget {
  const ReadQrCodeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ReadQrCodeScreenState();
}

class _ReadQrCodeScreenState extends State<ReadQrCodeScreen> {
  MobileScannerController? _controller;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    final status = await Permission.camera.request();
    setState(() => _permissionStatus = status);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    Widget content;
    if (_permissionStatus == PermissionStatus.granted) {
      content = _mobileScannerContent(localization);
    } else if (_permissionStatus == PermissionStatus.denied) {
      content = _textContent(
          localization, Colors.black, localization.cameraAccessDenied);
    } else if (_permissionStatus == PermissionStatus.permanentlyDenied) {
      content = _textContent(localization, Colors.black,
          localization.cameraAccessPermanentlyDenied);
    } else {
      content = _textContent(
          localization, Colors.black, localization.cameraInitializationFailed);
    }

    return AppScaffold(
      body: content,
    );
  }

  Widget _mobileScannerContent(AppLocalizations localization) {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Column(
          children: <Widget>[
            Expanded(
              child: MobileScanner(
                  controller: _controller,
                  onDetect: (barcode) {
                    if (barcode.raw != null) {
                      final String code = barcode.raw!;
                      final readQrCodeBloc = context.read<ReadQrCodeBloc>();
                      readQrCodeBloc.add(QrCodeScannedEvent(code));
                    }
                  }),
            ),
          ],
        ),
        const QrScannerOverlay(),
        _textContent(localization, Colors.white, null),
      ],
    );
  }

  Widget _textContent(
      AppLocalizations localization, Color color, String? text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText.title(
                localization.readQrCodeScreenTitle,
                textColor: color,
              ),
            ),
            Positioned(
              right: 8.0,
              child: CloseButton(
                color: color,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: text != null
                ? AppText.title(
                    text,
                    textColor: color,
                  )
                : null,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
