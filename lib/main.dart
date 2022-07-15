import 'package:flutter/material.dart';
import 'package:test_task/config/init.dart';

import 'app.dart';

void main() async {
  await init();

  runApp(
    const MyApp(),
  );
}
