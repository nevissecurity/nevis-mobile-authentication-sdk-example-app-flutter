// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/getit_root.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/app_navigation.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/theme/app_theme.dart';

late AppNavigation _appNavigation;
late GlobalNavigationManager _globalNavigationManager;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  configureDependencies();
  _appNavigation = GetIt.I.get<AppNavigation>();
  _globalNavigationManager = GetIt.I.get<GlobalNavigationManager>();

  debugPrint = (message, {wrapWidth}) {
    if (!kReleaseMode) {
      debugPrintThrottled(message, wrapWidth: wrapWidth);
    }
  };

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _globalNavigationManager.setNavigatorKey(_navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I.get<AppBloc>(),
      child: MaterialApp(
        theme: lightAppTheme,
        darkTheme: darkAppTheme,
        themeMode: ThemeMode.system,
        navigatorKey: _navigatorKey,
        initialRoute: AppNavigation.initialRoute,
        routes: _appNavigation.routes,
        builder: (ctx, child) {
          final isDark = Theme.of(ctx).brightness == Brightness.dark;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              // On iOS this names the background the status bar sits on,
              // on Android the two icon brightnesses name the icon color,
              // which is why they intentionally point in opposite directions.
              statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
              statusBarIconBrightness: isDark
                  ? Brightness.light
                  : Brightness.dark,
              systemStatusBarContrastEnforced: false,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: isDark
                  ? Brightness.light
                  : Brightness.dark,
              systemNavigationBarContrastEnforced: false,
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        locale: const Locale('en'),
      ),
    );
  }
}
