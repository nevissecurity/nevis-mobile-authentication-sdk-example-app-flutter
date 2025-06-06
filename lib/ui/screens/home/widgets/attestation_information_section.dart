// Copyright © 2025 Nevis Security AG. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/model/sdk_attestation_information.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/widgets/attestation_mode_list_tile.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';

class AttestationInformationSection extends StatelessWidget {
  final SdkAttestationInformation attestationInformation;

  const AttestationInformationSection({
    super.key,
    required this.attestationInformation,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.body(
          localization.homeSupportedAttestation,
        ),
        AttestationModeListTile(
          title: localization.homeSurrogateBasic,
          isSupported: attestationInformation.onlySurrogateBasic ||
              attestationInformation.onlyDefault ||
              attestationInformation.strict,
        ),
        AttestationModeListTile(
          title: localization.homeFullBasicDefault,
          isSupported: attestationInformation.onlyDefault ||
              attestationInformation.strict,
        ),
        AttestationModeListTile(
          title: localization.homeFullBasicStrict,
          isSupported: attestationInformation.strict,
        ),
      ],
    );
  }
}
