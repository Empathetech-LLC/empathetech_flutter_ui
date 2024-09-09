#!/bin/bash

set -e

flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/default_test.dart
flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/es_test.dart
flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/fr_test.dart
flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/lefty_test.dart
flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/minimum_config_test.dart
flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/maximum_config_test.dart