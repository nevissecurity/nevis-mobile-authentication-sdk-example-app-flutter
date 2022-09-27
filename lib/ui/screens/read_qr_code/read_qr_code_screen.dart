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
  const ReadQrCodeScreen({Key? key}) : super(key: key);

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
    final _localization = AppLocalizations.of(context)!;
    Widget content;
    if (_permissionStatus == PermissionStatus.granted) {
      content = _mobileScannerContent(_localization);
    } else if (_permissionStatus == PermissionStatus.denied) {
      content = _textContent(_localization, Colors.black, _localization.cameraAccessDenied);
    } else if (_permissionStatus == PermissionStatus.permanentlyDenied) {
      content = _textContent(_localization, Colors.black, _localization.cameraAccessPermanentlyDenied);
    } else {
      content = _textContent(_localization, Colors.black, _localization.cameraInitializationFailed);
    }

    return AppScaffold(
      body: content,
    );
  }

  Widget _mobileScannerContent(AppLocalizations localization) {
    _controller = MobileScannerController(facing: CameraFacing.back, torchEnabled: false);
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Column(
          children: <Widget>[
            Expanded(
              child: MobileScanner(
                  allowDuplicates: false,
                  controller: _controller,
                  onDetect: (barcode, args) {
                    if (barcode.rawValue != null) {
                      final String code = barcode.rawValue!;
                      final _readQrCodeBloc = context.read<ReadQrCodeBloc>();
                      _readQrCodeBloc.add(QrCodeScannedEvent(code));
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

  Widget _textContent(AppLocalizations localization, Color color, String? text) {
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
              child: CloseButton(
                color: color,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              right: 8.0,
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
