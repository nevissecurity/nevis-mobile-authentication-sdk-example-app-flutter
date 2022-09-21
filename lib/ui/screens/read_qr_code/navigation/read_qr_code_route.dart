// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/read_qr_code_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/read_qr_code_screen.dart';

class ReadQrCodeRoute {
  static const readQrCode = "read_qr_code";

  Map<String, WidgetBuilder> get routes => {
        readQrCode: (context) => BlocProvider<ReadQrCodeBloc>(
              create: (_) => GetIt.I.get<ReadQrCodeBloc>(),
              child: const ReadQrCodeScreen(),
            ),
      };
}
