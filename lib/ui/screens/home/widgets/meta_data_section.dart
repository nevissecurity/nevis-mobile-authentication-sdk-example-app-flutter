// Copyright © 2025 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/meta_data/sdk_meta_data.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/util/version_utils.dart';

class MetaDataSection extends StatelessWidget {
  final SdkMetaData metaData;

  const MetaDataSection({
    super.key,
    required this.metaData,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: AppText(text: localization.homeNevisMobileAuthenticationSdk),
          subtitle: AppText.footnote(
            metaData.sdkVersion?.formatted() ??
                localization.homeUnknownMetaData,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          title: AppText(text: localization.homeFacetId),
          subtitle: AppText.footnote(
            metaData.facetId ?? localization.homeUnknownMetaData,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        if (metaData.certificateFingerprint != null)
          ListTile(
            title: AppText(text: localization.homeCertificateFingerprint),
            subtitle: AppText.footnote(
              metaData.certificateFingerprint ??
                  localization.homeUnknownMetaData,
            ),
            contentPadding: EdgeInsets.zero,
          ),
      ],
    );
  }
}
