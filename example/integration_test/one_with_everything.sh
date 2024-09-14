#!/usr/bin/env bash

set -e

prefix=$HOME/repos/empathetech_flutter_ui/example

flutter drive --driver=$prefix/test_driver/integration_test_driver.dart --target=$prefix/integration_test/default_test.dart
flutter drive --driver=$prefix/test_driver/integration_test_driver.dart --target=$prefix/integration_test/es_test.dart
flutter drive --driver=$prefix/test_driver/integration_test_driver.dart --target=$prefix/integration_test/fr_test.dart
flutter drive --driver=$prefix/test_driver/integration_test_driver.dart --target=$prefix/integration_test/lefty_test.dart
flutter drive --driver=$prefix/test_driver/integration_test_driver.dart --target=$prefix/integration_test/minimum_config_test.dart
flutter drive --driver=$prefix/test_driver/integration_test_driver.dart --target=$prefix/integration_test/maximum_config_test.dart