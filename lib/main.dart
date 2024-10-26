import 'dart:async';

import 'package:flutter2048/core/app_runner.dart';
import 'package:flutter2048/core/refined_logger.dart';

void main() => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    );
