#!/bin/bash

flutter pub run intl_translation:generate_from_arb \
    --output-dir=lib/l10n/generated --no-use-deferred-loading \
    lib/app_l10n.dart lib/l10n/app_*.arb
