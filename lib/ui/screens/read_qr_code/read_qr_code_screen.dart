// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/l10n/app_localizations.dart';
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

class _ReadQrCodeScreenState extends State<ReadQrCodeScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  StreamSubscription<Object?>? _subscription;
  bool _isLoading = false;
  bool _isBarcodeFound = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = _controller.barcodes.listen(_handleBarcode);
    unawaited(_controller.start());
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    Widget content;
    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      content = _mobileScannerContent(localization);
    }

    return AppScaffold(
      body: content,
    );
  }

  Widget _mobileScannerContent(AppLocalizations localization) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Column(
          children: <Widget>[
            Expanded(
              child: MobileScanner(controller: _controller),
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
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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

  void _handleBarcode(BarcodeCapture barcodes) {
    if (_isBarcodeFound) {
      // Listener call twice on barcode detect
      // See: https://github.com/juliansteenbakker/mobile_scanner/issues/1079
      return;
    }

    if (mounted) {
      setState(() {
        if (barcodes.barcodes.isNotEmpty &&
            barcodes.barcodes.first.rawValue != null) {
          _isBarcodeFound = true;
          final String code = barcodes.barcodes.first.rawValue!;
          final readQrCodeBloc = context.read<ReadQrCodeBloc>();
          readQrCodeBloc.add(QrCodeScannedEvent(code));
          setState(() => _isLoading = true);
        }
      });
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await _controller.dispose();
  }
}
