// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

class QrScannerOverlay extends StatelessWidget {
  final Color color;
  final double opacity;

  const QrScannerOverlay({
    Key? key,
    this.color = Colors.black,
    this.opacity = 0.4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _expandedOpacityBox(flex: 3),
        Expanded(
            flex: 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _expandedOpacityBox(flex: 1),
                const Expanded(
                  flex: 8,
                  child: FittedBox(
                    fit: BoxFit.fill,
                  ),
                ),
                _expandedOpacityBox(flex: 1),
              ],
            )),
        _expandedOpacityBox(flex: 3),
      ],
    );
  }

  Widget _expandedOpacityBox({required int flex}) {
    return Expanded(
      flex: flex,
      child: Opacity(
        opacity: opacity,
        child: DecoratedBox(
          decoration: BoxDecoration(color: color),
        ),
      ),
    );
  }
}
