// Copyright © 2025 Nevis Security AG. All rights reserved.

class SdkAttestationInformation {
  final bool onlySurrogateBasic;
  final bool onlyDefault;
  final bool strict;

  SdkAttestationInformation.onlySurrogateBasic()
      : onlySurrogateBasic = true,
        onlyDefault = false,
        strict = false;

  SdkAttestationInformation.onlyDefault()
      : onlySurrogateBasic = true,
        onlyDefault = true,
        strict = false;

  SdkAttestationInformation.strict()
      : onlySurrogateBasic = true,
        onlyDefault = true,
        strict = true;
}
