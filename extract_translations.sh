#!/bin/sh

flutter pub run intl_translation:extract_to_arb \
  --locale en_US \
  --output-dir=translations/ \
  --output-file=app_en_US.arb \
  --require_descriptions \
  lib/localization.dart