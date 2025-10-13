// Copyright © 2025 Nevis Security AG. All rights reserved.

class SdkAttestationInformation {
  final bool onlySurrogateBasic;
  final bool onlyDefault;
  final bool strict;
  final bool strongBox;

  SdkAttestationInformation.onlySurrogateBasic()
      : onlySurrogateBasic = true,
        onlyDefault = false,
        strict = false,
        strongBox = false;

  SdkAttestationInformation.onlyDefault()
      : onlySurrogateBasic = true,
        onlyDefault = true,
        strict = false,
        strongBox = false;

  SdkAttestationInformation.strict()
      : onlySurrogateBasic = true,
        onlyDefault = true,
        strict = true,
        strongBox = false;

  SdkAttestationInformation.strictStrongBox()
      : onlySurrogateBasic = true,
        onlyDefault = true,
        strict = true,
        strongBox = true;
}
